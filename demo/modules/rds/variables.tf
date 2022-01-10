#  RDS Input Variables

variable "rds_allocatd_storage" {
  description = "rds initial allocated storage"
  type        = number
  default     = 10
}

variable "rds_database_engine" {
  description = "Database Engine eg mysql, postgresql"
  type        = string
  default     = "mysql"
}

variable "rds_database_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "5.7"
}

variable "rds_db_instance_type" {
  description = "Database Instance Type"
  type        = string
  default     = "db.t2.micro"
}

variable "rds_initial_database_name" {
  description = "Database Name"
  type        = string
  default     = "mydb"
}

variable "rds_database_username" {
  description = "Datbase User Name"
  type        = string
  default     = "admin"
}

variable "rds_database_user_password" {
  description = "Database User Password"
  type        = string
  default     = ""
}

variable "rds_parameter_group_name" {
  description = "Parameter Group Name"
  type        = string
  default     = "default.mysql5.7"
}

variable "rds_max_allocated_storage" {
  description = "Database Max Allocated storage"
  type        = number
  default     = 1000
}

variable "rds_db_engine_auto_minor_version_upgrade" {
  description = "rds database Engine Auto Minor Version Upgrade"
  type        = bool
  default     = false
}

variable "rds_database_publicly_access" {
  description = "Database Public Access"
  type        = bool
  default     = false
}

variable "rds_delete_automated_backups" {
  description = "rds_delete_automated_backups"
  type        = bool
  default     = false
}

variable "rds_skip_final_snapshot" {
  description = "rds_skip_final_snapshot"
  type        = bool
  default     = false
}

variable "tags" {
  type = map(any)
}

variable "rds_vpc_security_group_ids" {
  description = "RDS instance Security Group"
  type        = list(any)
}