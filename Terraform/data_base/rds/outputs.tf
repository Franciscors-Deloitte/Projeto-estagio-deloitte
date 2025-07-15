output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.this[0].id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this[0].arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.this[0].endpoint
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.this[0].address
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.this[0].port
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.this[0].status
}