output "cloudtrail_id" {
  description = "The name of the CloudTrail"
  value       = try(aws_cloudtrail.this[0].id, null)
}

output "cloudtrail_arn" {
  description = "The ARN of the CloudTrail"
  value       = try(aws_cloudtrail.this[0].arn, null)
}

output "cloudtrail_home_region" {
  description = "The region in which the trail was created"
  value       = try(aws_cloudtrail.this[0].home_region, null)
}