##################################
# ALB
##################################
resource "aws_lb" "this" {
  count = var.create ? 1 : 0

  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets
  security_groups    = var.security_groups
  ip_address_type    = var.ip_address_type
  idle_timeout       = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection

  dynamic "access_logs" {
    for_each = length(var.access_logs) > 0 ? [var.access_logs] : []
    content {
      bucket  = access_logs.value.bucket
      enabled = try(access_logs.value.enabled, true)
      prefix  = try(access_logs.value.prefix, null)
    }
  }

  tags = merge(var.tags, {
    Name                   = replace(var.name, ".", "-")
    terraform-aws-modules = "alb"
  })
}