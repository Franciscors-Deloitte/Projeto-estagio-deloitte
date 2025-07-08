data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id          = data.aws_caller_identity.current.account_id
  partition           = data.aws_partition.current.partition
  dns_suffix          = data.aws_partition.current.dns_suffix
  region              = data.aws_region.current.name
  role_name_condition = var.role_name != null ? var.role_name : "${var.role_name_prefix}*"
}

data "aws_iam_policy_document" "this" {
  count = var.create_role ? 1 : 0

  dynamic "statement" {
    for_each = var.oidc_providers
    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.provider_arn]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "^(.*provider/)", "")}:sub"
        values   = [
          for sa in statement.value.namespace_service_accounts : "system:serviceaccount:${sa}"
        ]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "^(.*provider/)", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }
    }
  }
}

# -------- IAM Role --------------------
resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                  = var.role_name
  name_prefix           = var.role_name_prefix
  path                  = var.role_path
  description           = var.role_description
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  assume_role_policy = data.aws_iam_policy_document.this[0].json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for k, v in var.role_policy_arns : k => v if var.create_role
  }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}