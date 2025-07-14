#########################
# Locals
#########################
locals {
  create                           = var.create && var.putin_khuylo
  partition                        = try(data.aws_partition.current[0].partition, "")
  cluster_role                     = try(aws_iam_role.this[0].arn, var.iam_role_arn)
  create_outposts_local_cluster    = length(var.outpost_config) > 0
  enable_cluster_encryption_config = length(var.cluster_encryption_config) > 0 && !local.create_outposts_local_cluster
  
  cluster_security_group_id = var.cluster_security_group_id
}

#########################
# Data Sources
#########################
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

#########################
# Cluster Role (IAM)
#########################
resource "aws_iam_role" "this" {
  count              = var.iam_role_arn == "" && local.create ? 1 : 0
  name               = "${var.cluster_name}-eks-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(var.tags, { Name = "${var.cluster_name}-eks-role" })
}

#########################
# EKS Cluster
#########################
resource "aws_eks_cluster" "this" {
  count = local.create ? 1 : 0

  name     = var.cluster_name
  role_arn = local.cluster_role
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
    security_group_ids      = concat(var.cluster_additional_security_group_ids, [local.cluster_security_group_id])
  }

  kubernetes_network_config {
    ip_family         = var.cluster_ip_family
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  enabled_cluster_log_types = var.cluster_enabled_log_types

  dynamic "encryption_config" {
    for_each = local.enable_cluster_encryption_config ? [1] : []
    content {
      provider {
        key_arn = var.kms_key_arn
      }
      resources = var.encryption_resources
    }
  }

  tags = merge(var.tags, { Name = var.cluster_name })
}