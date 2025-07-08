locals {
  group_name = var.create_group ? aws_iam_group.this[0].id : var.name
}

resource "aws_iam_group" "this" {
  count = var.create_group ? 1 : 0

  name = var.name
  path = var.path
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = local.group_name
  name  = var.name
  users = var.group_users
}

resource "aws_iam_group_policy_attachment" "this" {
  count = length(var.policy_arns)

  group      = local.group_name
  policy_arn = var.policy_arns[count.index]
}
