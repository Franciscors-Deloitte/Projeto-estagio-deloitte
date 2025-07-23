# ========================
# LOCALS
# ========================
locals {
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  default_update_config = {
    max_unavailable_percentage = 33
  }

  default_instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 66
    }
  }

  kubernetes_network_config = try(aws_eks_cluster.this[0].kubernetes_network_config[0], {})
}

# ========================
# WAIT UNTIL EKS CLUSTER IS READY
# ========================
resource "time_sleep" "this" {
  count = var.create ? 1 : 0

  create_duration = var.dataplane_wait_duration

  triggers = {
    cluster_name                        = aws_eks_cluster.this[0].id
    cluster_endpoint                    = aws_eks_cluster.this[0].endpoint
    cluster_version                     = aws_eks_cluster.this[0].version
    cluster_service_cidr                = var.cluster_ip_family == "ipv6" ? try(local.kubernetes_network_config.service_ipv6_cidr, "") : try(local.kubernetes_network_config.service_ipv4_cidr, "")
    cluster_certificate_authority_data = aws_eks_cluster.this[0].certificate_authority[0].data
  }
}

# ========================
# IAM POLICY FOR IPV6 (OPTIONAL)
# ========================
data "aws_iam_policy_document" "cni_ipv6_policy" {
  count = var.create && var.create_cni_ipv6_iam_policy ? 1 : 0

  statement {
    sid     = "AssignDescribe"
    actions = [
      "ec2:AssignIpv6Addresses",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeInstanceTypes"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "CreateTags"
    actions = ["ec2:CreateTags"]
    resources = ["arn:${local.partition}:ec2:*:*:network-interface/*"]
  }
}

resource "aws_iam_policy" "cni_ipv6_policy" {
  count       = var.create && var.create_cni_ipv6_iam_policy ? 1 : 0
  name        = "AmazonEKS_CNI_IPv6_Policy"
  description = "IAM policy for EKS CNI to assign IPV6 addresses"
  policy      = data.aws_iam_policy_document.cni_ipv6_policy[0].json
  tags        = var.tags
}