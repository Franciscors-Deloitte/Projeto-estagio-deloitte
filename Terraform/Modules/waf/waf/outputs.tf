output "web_acl_id" {
  description = "ID of the WAFv2 Web ACL"
  value       = try(aws_wafv2_web_acl.this[0].id, null)
}

output "web_acl_arn" {
  description = "ARN of the WAFv2 Web ACL"
  value       = try(aws_wafv2_web_acl.this[0].arn, null)
}

output "web_acl_name" {
  description = "Name of the WAFv2 Web ACL"
  value       = try(aws_wafv2_web_acl.this[0].name, null)
}