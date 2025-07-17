##################################
# Locals
##################################
locals {
  enabled_endpoints = {
    for name, config in var.endpoints :
    name => config
    if config.create
  }
}

##################################
# VPC Endpoints
##################################
resource "aws_vpc_endpoint" "this" {
  for_each = local.enabled_endpoints

  vpc_id              = var.vpc_id
  service_name        = each.value.service
  vpc_endpoint_type   = each.value.type
  private_dns_enabled = try(each.value.private_dns_enabled, null)
  security_group_ids  = try(each.value.security_group_ids, var.security_group_ids)
  subnet_ids          = try(each.value.subnet_ids, var.subnet_ids)

  tags = merge(var.tags, {
    Name = replace(each.key, ".", "-")
  })
}
