output "iam_user_name" {
  description = "The user's name"
  value       = try(aws_iam_user.this[0].name, "")
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = try(aws_iam_user.this[0].arn, "")
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = try(aws_iam_user.this[0].unique_id, "")
}

output "iam_user_login_profile_password" {
  description = "The user password"
  value       = lookup(try(aws_iam_user_login_profile.this[0], {}), "password", sensitive(""))
  sensitive   = true
}

output "policy_arns" {
  description = "The list of ARNs of policies directly assigned to the IAM user"
  value       = [for policy_attachment in aws_iam_user_policy_attachment.this : policy_attachment.policy_arn]
}
