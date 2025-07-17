output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = try(aws_db_instance.this[0].identifier, null)
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = try(aws_db_instance.this[0].arn, null)
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = try(aws_db_instance.this[0].endpoint, null)
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = try(aws_db_instance.this[0].address, null)
}

output "db_instance_port" {
  description = "The database port"
  value       = try(aws_db_instance.this[0].port, null)
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = try(aws_db_instance.this[0].status, null)
}