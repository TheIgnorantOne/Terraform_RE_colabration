data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}
#### EC2 Instance Configuration ########

module "ec2_instance" {
  count              = var.instance_count
  source             = "./modules/ec2_instance"
  instance_ami       = var.instance_ami
  security_group_ids = ["${module.instance_sg.security_group_id}"]
  instance_keypair   = var.instance_keypair
  subnet_id          = sort(data.aws_subnet_ids.subnets.ids)[count.index % 2]
  tags = {
    Name = var.instance_name
  }
}

resource "aws_ami_from_instance" "nginx-wordpress" {
  depends_on = [
    null_resource.ansible_configuration
  ]
  name               = "nginx-wordpress"
  source_instance_id = module.ec2_instance[0].instance_id[0]
}

module "instance_sg" {
  source              = "./modules/security_group"
  security_group_name = "${var.name}-webserver-sg"
  vpc_id              = var.vpc_id
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
    },
  ]
}
#### ALB Configuration ############
module "sg_alb" {
  source              = "./modules/security_group"
  security_group_name = "alb"
  vpc_id              = var.vpc_id
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    },
  ]
}
module "wordpress_alb" {
  depends_on = [
    module.sg_alb
  ]
  source    = "./modules/alb"
  create_lb = true

  name               = "${var.name}-webserver-alb"
  name_prefix        = "wordpress"
  vpc_id             = var.vpc_id
  load_balancer_type = "application"
  internal           = false
  security_groups    = [module.sg_alb.security_group_id]
  subnets            = data.aws_subnet_ids.subnets.ids

  idle_timeout                     = 60
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
    Name = "Wordpress Application Load Balancer"
  }

  target_groups = [
    {
      name             = "wordpress-tg-a"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
    {
      name             = "wordpress-tg-b"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = module.wordpress_alb.lb_arn[0]
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = module.wordpress_alb.target_group_arns[0]
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100

  action {
    type = "forward"
    forward {
      target_group {
        arn    = module.wordpress_alb.target_group_arns[0]
        weight = 100 / length(module.wordpress_alb.target_group_arns)
      }
      target_group {
        arn    = module.wordpress_alb.target_group_arns[1]
        weight = 100 / length(module.wordpress_alb.target_group_arns)
      }
    }
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}


##### Auto Scaling Group Configuration #########

resource "aws_launch_template" "asg_template" {
  depends_on             = [aws_ami_from_instance.nginx-wordpress]
  name_prefix            = var.prefix
  image_id               = aws_ami_from_instance.nginx-wordpress.id
  instance_type          = var.asg_template_instance_type
  vpc_security_group_ids = [module.instance_sg.security_group_id]
  key_name               = var.instance_keypair
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.instance_name
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_capacity
  min_size            = var.asg_min_capacity
  vpc_zone_identifier = data.aws_subnet_ids.subnets.ids
  target_group_arns   = module.wordpress_alb.target_group_arns

  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
}

###### RDS Configuration ######
module "rds_mysql_instance" {
  source                                   = "./modules/rds"
  rds_allocatd_storage                     = 10
  rds_database_engine                      = "mysql"
  rds_database_engine_version              = "5.7"
  rds_db_instance_type                     = "db.t2.micro"
  rds_initial_database_name                = "wordpress_db"
  rds_database_username                    = "root"
  rds_database_user_password               = "9aiv5e78"
  rds_parameter_group_name                 = "default.mysql5.7"
  rds_max_allocated_storage                = 1000
  rds_db_engine_auto_minor_version_upgrade = true
  rds_delete_automated_backups             = true
  rds_database_publicly_access             = true
  rds_skip_final_snapshot                  = true
  rds_vpc_security_group_ids               = ["${module.rds_sg.security_group_id}"]
  tags = {
    Name = "${var.name}-wordpress-backend-mysql"
  }
}

module "rds_sg" {
  source              = "./modules/security_group"
  security_group_name = "rds_mysql_sg"
  vpc_id              = var.vpc_id
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    },
  ]
}
