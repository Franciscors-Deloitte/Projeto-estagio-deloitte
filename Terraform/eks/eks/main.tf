# ========================
# LOCALS
# ========================
locals {
  create                           = var.create && var.putin_khuylo
  partition                        = try(data.aws_partition.current[0].partition, "")
  cluster_role                     = try(aws_iam_role.this[0].arn, var.iam_role_arn)
  create_outposts_local_cluster    = length(var.outpost_config) > 0
  enable_cluster_encryption_config = length(var.cluster_encryption_config) > 0 && !local.create_outposts_local_cluster
  auto_mode_enabled                = try(var.cluster_compute_config.enabled, false)
  cluster_security_group_id = var.cluster_security_group_id != "" ? var.cluster_security_group_id : aws_security_group.cluster[0].id
}

# ========================
# DATA SOURCES
# ========================
data "aws_partition" "current" {
  count = local.create ? 1 : 0
}

data "aws_caller_identity" "current" {
  count = local.create ? 1 : 0
}

data "aws_iam_session_context" "current" {
  count = local.create ? 1 : 0
  arn   = try(data.aws_caller_identity.current[0].arn, "")
}

# ========================
# EKS CLUSTER RESOURCE
# ========================
resource "aws_eks_cluster" "this" {
  count = local.create ? 1 : 0

  name                          = var.cluster_name
  role_arn                      = local.cluster_role
  version                       = var.cluster_version
  enabled_cluster_log_types     = var.cluster_enabled_log_types
  bootstrap_self_managed_addons = local.auto_mode_enabled ? coalesce(var.bootstrap_self_managed_addons, false) : var.bootstrap_self_managed_addons
  force_update_version          = var.cluster_force_update_version

  access_config {
    authentication_mode = var.authentication_mode
    bootstrap_cluster_creator_admin_permissions = false
  }

  dynamic "compute_config" {
    for_each = length(var.cluster_compute_config) > 0 ? [var.cluster_compute_config] : []

    content {
      enabled       = local.auto_mode_enabled
      node_pools    = local.auto_mode_enabled ? try(compute_config.value.node_pools, []) : null
      node_role_arn = local.auto_mode_enabled && length(try(compute_config.value.node_pools, [])) > 0 ? try(compute_config.value.node_role_arn, aws_iam_role.eks_auto[0].arn, null) : null
    }
  }

  vpc_config {
    security_group_ids      = compact(distinct(concat(var.cluster_additional_security_group_ids, [local.cluster_security_group_id])))
    subnet_ids              = coalescelist(var.control_plane_subnet_ids, var.subnet_ids)
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  kubernetes_network_config {
    ip_family         = var.cluster_ip_family
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  encryption_config {
    provider {
      key_arn = var.kms_key_arn
    }
    resources = var.encryption_resources
  }

  tags = var.tags
}