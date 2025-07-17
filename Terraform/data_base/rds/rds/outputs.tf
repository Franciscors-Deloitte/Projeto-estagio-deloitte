output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = module.db_instance.db_instance_identifier
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.db_instance.db_instance_arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.db_instance.db_instance_endpoint
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.db_instance.db_instance_address
}

output "db_instance_port" {
  description = "The database port"
  value       = module.db_instance.db_instance_port
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = module.db_instance.db_instance_status
}