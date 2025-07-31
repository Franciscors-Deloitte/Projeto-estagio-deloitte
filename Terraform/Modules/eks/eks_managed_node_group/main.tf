##################################
# Managed Node Group
##################################

resource "aws_eks_node_group" "this" {
  count = var.create ? 1 : 0

  cluster_name    = var.cluster_name
  node_group_name = var.name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  instance_types = var.instance_types
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  ami_type       = var.ami_type
  version        = var.kubernetes_version
  release_version = var.release_version

  labels = var.labels

  tags = merge(
    var.tags,
    {
      "Name" = replace(var.name, ".", "-")
    }
  )

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  depends_on = [
  aws_iam_role.this
]
}