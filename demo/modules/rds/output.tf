output "rds_address" {
  value = aws_db_instance.rds_instace.address
}
output "rds_initial_database_name" {
  value = aws_db_instance.rds_instace.name
}

output "rds_database_username" {
  value = aws_db_instance.rds_instace.username
}

output "rds_database_user_password" {
  value = aws_db_instance.rds_instace.password
}