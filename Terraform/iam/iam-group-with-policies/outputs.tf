output "group_arn" {
  description = "IAM group arn"
  value       = try(aws_iam_group.this[0].arn, "")
}

output "group_users" {
  description = "List of IAM users in IAM group"
  value       = flatten(aws_iam_group_membership.this[*].users)
}

output "group_name" {
  description = "IAM group name"
  value       = try(aws_iam_group.this[0].name, var.name)
}

output "attached_policy_arns" {
  description = "ARNs of policies attached to the group"
  value = concat(
    [for a in aws_iam_group_policy_attachment.iam_self_management : a.policy_arn],
    [for a in aws_iam_group_policy_attachment.custom_arns          : a.policy_arn],
    [for a in aws_iam_group_policy_attachment.custom               : a.policy_arn]
  )
}
