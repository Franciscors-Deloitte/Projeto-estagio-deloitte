##############################
# aws-auth ConfigMap
##############################

locals {
  aws_auth_configmap_data = {
    mapRoles    = yamlencode(var.aws_auth_roles)
    mapUsers    = yamlencode(var.aws_auth_users)
    mapAccounts = yamlencode(var.aws_auth_accounts)
  }
}

resource "kubernetes_config_map" "aws_auth" {
  count = var.create && var.create_aws_auth_configmap ? 1 : 0

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
    labels    = var.labels
  }

  data = local.aws_auth_configmap_data

  lifecycle {
    ignore_changes = [
      data,
      metadata[0].labels,
      metadata[0].annotations
    ]
  }
}