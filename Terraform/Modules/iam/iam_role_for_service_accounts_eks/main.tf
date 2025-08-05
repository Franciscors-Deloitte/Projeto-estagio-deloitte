data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  dns_suffix = data.aws_partition.current.dns_suffix
  region     = data.aws_region.current.id
}

data "aws_iam_policy_document" "this" {
  count = var.create_role && length(var.oidc_providers) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = var.allow_self_assume_role ? [1] : []

    content {
      sid     = "ExplicitSelfRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = [
          "arn:${local.partition}:iam::${local.account_id}:role${var.role_path}${var.role_name != null ? var.role_name : "${var.role_name_prefix}*"}"
        ]
      }
    }
  }

  dynamic "statement" {
    for_each = {
      for k, v in var.oidc_providers : k => v
      if try(v.provider_arn, null) != null
    }

    content {
      sid     = "AllowAssumeRoleWithWebIdentity"
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.provider_arn]
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(statement.value.provider_arn, "/^(.*provider\\/)/", "")}:sub"
        values   = statement.value.namespace_service_accounts
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(statement.value.provider_arn, "/^(.*provider\\/)/", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.role_policy_arns : k => v if var.create_role }

  role       = var.iam_role_name
  policy_arn = each.value
}