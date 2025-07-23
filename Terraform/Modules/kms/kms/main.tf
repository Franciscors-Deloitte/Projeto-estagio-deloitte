##################################
# Data Sources
##################################
data "aws_partition" "current" {
  count = var.create ? 1 : 0
}

data "aws_caller_identity" "current" {
  count = var.create ? 1 : 0
}

locals {
  account_id = try(data.aws_caller_identity.current[0].account_id, "")
  partition  = try(data.aws_partition.current[0].partition, "")
  dns_suffix = try(data.aws_partition.current[0].dns_suffix, "")
}

##################################
# KMS Key
##################################
resource "aws_kms_key" "this" {
  count = var.create ? 1 : 0

  description                        = var.description
  deletion_window_in_days            = var.deletion_window_in_days
  enable_key_rotation                = var.enable_key_rotation
  is_enabled                         = var.is_enabled
  customer_master_key_spec           = var.customer_master_key_spec
  key_usage                          = var.key_usage
  multi_region                       = var.multi_region
  policy                             = var.policy
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check

  tags = merge(var.tags, {
    Name = replace(var.name, ".", "-")
  })
}

##################################
# KMS Alias (Optional)
##################################
resource "aws_kms_alias" "this" {
  count         = var.create && var.alias_name != null ? 1 : 0
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.this[0].key_id
}