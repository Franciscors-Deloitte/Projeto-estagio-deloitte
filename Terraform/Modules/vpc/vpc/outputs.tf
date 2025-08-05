################################################################################
# VPC Outputs
################################################################################

output "vpc_id" {
  description = "ID of the VPC"
  value       = try(aws_vpc.this[0].id, null)
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = try(aws_vpc.this[0].arn, null)
}

################################################################################
# Subnet Outputs
################################################################################

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

################################################################################
# Route Table Outputs
################################################################################

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = try(aws_route_table.public[0].id, null)
}

################################################################################
# Internet Gateway Output
################################################################################

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].id, null)
}

################################################################################
# RDS VPC Output
################################################################################

output "db_subnet_group_name" {
  value       = aws_db_subnet_group.rds.name
  description = "Nome do grupo de sub-redes para RDS"
}