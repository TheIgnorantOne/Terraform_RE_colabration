resource "aws_lb" "this" {
  count = var.create_lb ? 1 : 0

  name = var.name

  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  security_groups    = var.security_groups
  subnets            = var.subnets

  idle_timeout                     = var.idle_timeout
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  tags                             = var.tags
}

resource "aws_lb_target_group" "main" {
  count = var.create_lb ? length(var.target_groups) : 0

  name = lookup(var.target_groups[count.index], "name", null)

  vpc_id      = var.vpc_id
  port        = lookup(var.target_groups[count.index], "backend_port", null)
  protocol    = lookup(var.target_groups[count.index], "backend_protocol", null)
  target_type = lookup(var.target_groups[count.index], "target_type", null)
}