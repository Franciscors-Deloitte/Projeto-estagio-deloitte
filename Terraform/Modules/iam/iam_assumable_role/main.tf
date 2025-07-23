data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id                         = data.aws_caller_identity.current.account_id
  partition                          = data.aws_partition.current.partition
  role_sts_externalid                = flatten([var.role_sts_externalid])
  role_name_condition                = var.role_name != null ? var.role_name : "${var.role_name_prefix}*"
  custom_role_trust_policy_condition = var.create_custom_role_trust_policy ? var.custom_role_trust_policy : ""
  create_iam_role_inline_policy      = var.create_role && length(var.inline_policy_statements) > 0
}

# Trust Policy sem MFA
data "aws_iam_policy_document" "assume_role" {
  count = !var.create_custom_role_trust_policy && !var.role_requires_mfa ? 1 : 0

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
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.role_path}${local.role_name_condition}"]
      }
    }
  }

  statement {
    effect  = "Allow"
    actions = compact(distinct(concat(["sts:AssumeRole"], var.trusted_role_actions)))

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services
    }

    dynamic "condition" {
      for_each = length(local.role_sts_externalid) != 0 ? [true] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = local.role_sts_externalid
      }
    }

    dynamic "condition" {
      for_each = var.role_requires_session_name ? [1] : []
      content {
        test     = "StringEquals"
        variable = "sts:RoleSessionName"
        values   = var.role_session_name
      }
    }

    dynamic "condition" {
      for_each = var.trust_policy_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

# Trust Policy com MFA
data "aws_iam_policy_document" "assume_role_with_mfa" {
  count = !var.create_custom_role_trust_policy && var.role_requires_mfa ? 1 : 0

  statement {
    effect  = "Allow"
    actions = compact(distinct(concat(["sts:AssumeRole"], var.trusted_role_actions)))

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.mfa_age]
    }

    dynamic "condition" {
      for_each = length(local.role_sts_externalid) != 0 ? [true] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = local.role_sts_externalid
      }
    }

    dynamic "condition" {
      for_each = var.role_requires_session_name ? [1] : []
      content {
        test     = "StringEquals"
        variable = "sts:RoleSessionName"
        values   = var.role_session_name
      }
    }

    dynamic "condition" {
      for_each = var.trust_policy_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                 = var.role_name
  name_prefix          = var.role_name_prefix
  path                 = var.role_path
  max_session_duration = var.max_session_duration
  description          = var.role_description

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permissions_boundary_arn

  assume_role_policy = coalesce(
    local.custom_role_trust_policy_condition,
    try(data.aws_iam_policy_document.assume_role_with_mfa[0].json,
        data.aws_iam_policy_document.assume_role[0].json)
  )

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.create_role ? var.role_policy_arns : {}

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "inline" {
  count = local.create_iam_role_inline_policy ? 1 : 0

  name = "${aws_iam_role.this[0].name}-inline"
  role = aws_iam_role.this[0].id

  policy = data.aws_iam_policy_document.inline[0].json
}

data "aws_iam_policy_document" "inline" {
  count = local.create_iam_role_inline_policy ? 1 : 0

  dynamic "statement" {
    for_each = var.inline_policy_statements
    content {
      sid    = try(statement.value.sid, null)
      effect = statement.value.effect

      actions   = statement.value.actions
      resources = try(statement.value.resources, null)

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}