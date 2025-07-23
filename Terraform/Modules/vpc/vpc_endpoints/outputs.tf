output "endpoints" {
  description = "Map of all VPC endpoints created"
  value       = aws_vpc_endpoint.this
}