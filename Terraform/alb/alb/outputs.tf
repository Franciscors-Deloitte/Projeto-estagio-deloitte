################################################################################
# Load Balancer
################################################################################

output "id" {
  description = "The ID of the ALB"
  value       = try(aws_lb.this[0].id, null)
}

output "arn" {
  description = "The ARN of the ALB"
  value       = try(aws_lb.this[0].arn, null)
}

output "arn_suffix" {
  description = "ARN suffix of the ALB (useful for CloudWatch)"
  value       = try(aws_lb.this[0].arn_suffix, null)
}

output "dns_name" {
  description = "The DNS name of the ALB"
  value       = try(aws_lb.this[0].dns_name, null)
}

output "zone_id" {
  description = "The zone ID of the ALB (for DNS integrations)"
  value       = try(aws_lb.this[0].zone_id, null)
}