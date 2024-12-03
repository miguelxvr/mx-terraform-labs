output "db_security_group_id" {
  description = "The ID of the security group associated with RDS"
  value       = module.db_security_group.security_group_id
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.mariadb.db_instance_endpoint
}

output "db_instance_name" {
  description = "The database name"
  value       = module.mariadb.db_instance_name
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = module.mariadb.db_instance_identifier
}

output "db_instance_address" {
  description = "The RDS Resource ID of this instance"
  value       = module.mariadb.db_instance_address
}

output "db_instance_username" {
  description = "The username of the RDS instance"
  value       = module.mariadb.db_instance_username
}

output "db_secretsmanager_id" {
  description = "The RDS secret ID"
  value       = aws_secretsmanager_secret.password.id
}
