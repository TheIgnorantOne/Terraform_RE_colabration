# Launching RDS service

resource "aws_db_instance" "rds_instace" {
  allocated_storage          = var.rds_allocatd_storage
  engine                     = var.rds_database_engine
  engine_version             = var.rds_database_engine_version
  instance_class             = var.rds_db_instance_type
  name                       = var.rds_initial_database_name
  username                   = var.rds_database_username
  password                   = var.rds_database_user_password
  parameter_group_name       = var.rds_parameter_group_name
  max_allocated_storage      = var.rds_max_allocated_storage
  auto_minor_version_upgrade = var.rds_db_engine_auto_minor_version_upgrade
  delete_automated_backups   = var.rds_delete_automated_backups
  publicly_accessible        = var.rds_database_publicly_access
  vpc_security_group_ids     = var.rds_vpc_security_group_ids
  skip_final_snapshot        = var.rds_skip_final_snapshot
  tags                       = var.tags
}