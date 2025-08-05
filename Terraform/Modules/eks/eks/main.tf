#########################
# Locals
#########################
locals {
  create                           = var.create
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

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
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
  for_each = var.clusters

  name     = each.value.cluster_name
  role_arn = each.value.iam_role_arn

  version = each.value.cluster_version
  enabled_cluster_log_types = each.value.cluster_enabled_log_types

  kubernetes_network_config {
    service_ipv4_cidr = each.value.cluster_service_ipv4_cidr
    ip_family          = each.value.cluster_ip_family
  }

  vpc_config {
    subnet_ids              = each.value.subnet_ids
    endpoint_private_access = each.value.cluster_endpoint_private_access
    endpoint_public_access  = each.value.cluster_endpoint_public_access
    public_access_cidrs     = each.value.cluster_endpoint_public_access_cidrs
    security_group_ids      = concat(
      [each.value.cluster_security_group_id],
      each.value.cluster_additional_security_group_ids
    )
  }

  dynamic "encryption_config" {
    for_each = length(each.value.encryption_resources) > 0 ? [1] : []
    content {
      provider {
        key_arn = each.value.kms_key_arn
      }
      resources = each.value.encryption_resources
    }
  }

  tags = merge(
    {
      Name = each.value.cluster_name
    },
    each.value.tags
  )
}