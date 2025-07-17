##################################
# KMS Key
##################################
output "key_arn" {
  description = "ARN of the KMS key"
  value       = try(aws_kms_key.this[0].arn, null)
}

output "key_id" {
  description = "ID of the KMS key"
  value       = try(aws_kms_key.this[0].key_id, null)
}

output "key_policy" {
  description = "The IAM resource policy set on the KMS key"
  value       = try(aws_kms_key.this[0].policy, null)
}

##################################
# Alias
##################################
output "alias_name" {
  description = "Name of the alias created (if any)"
  value       = try(aws_kms_alias.this[0].name, null)
}