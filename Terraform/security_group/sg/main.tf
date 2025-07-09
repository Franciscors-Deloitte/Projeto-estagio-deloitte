#########################
# Locals
#########################
locals {
  ingress_rules = var.create && var.create_sg ? var.ingress_rules : []
  egress_rules  = var.create && var.create_sg ? var.egress_rules  : []
}

#########################
# Security Group
#########################
resource "aws_security_group" "this" {
  count                   = var.create ? 1 : 0
  name                    = var.use_name_prefix ? null : var.name
  name_prefix             = var.use_name_prefix ? "${var.name}-" : null
  description             = var.description
  vpc_id                  = var.vpc_id
  revoke_rules_on_delete  = var.revoke_rules_on_delete

  tags = merge(
    var.tags,
    { Name = replace(var.name, ".", "-") }
  )
}

#########################
# Ingress rules
#########################
resource "aws_security_group_rule" "ingress" {
  count             = length(local.ingress_rules)
  type              = "ingress"
  security_group_id = aws_security_group.this[0].id

  protocol  = local.ingress_rules[count.index].protocol
  from_port = local.ingress_rules[count.index].from_port
  to_port   = local.ingress_rules[count.index].to_port

  cidr_blocks              = try(local.ingress_rules[count.index].cidr_blocks, [])
  ipv6_cidr_blocks         = try(local.ingress_rules[count.index].ipv6_cidr_blocks, [])
  prefix_list_ids          = try(local.ingress_rules[count.index].prefix_list_ids, [])
  source_security_group_id = try(local.ingress_rules[count.index].source_security_group_id, null)
  self                     = try(local.ingress_rules[count.index].self, null)
  description              = try(local.ingress_rules[count.index].description, null)
}

#########################
# Egress rules
#########################
resource "aws_security_group_rule" "egress" {
  count             = length(local.egress_rules)
  type              = "egress"
  security_group_id = aws_security_group.this[0].id

  protocol  = local.egress_rules[count.index].protocol
  from_port = local.egress_rules[count.index].from_port
  to_port   = local.egress_rules[count.index].to_port

  cidr_blocks              = try(local.egress_rules[count.index].cidr_blocks, ["0.0.0.0/0"])
  ipv6_cidr_blocks         = try(local.egress_rules[count.index].ipv6_cidr_blocks, ["::/0"])
  prefix_list_ids          = try(local.egress_rules[count.index].prefix_list_ids, [])
  source_security_group_id = try(local.egress_rules[count.index].source_security_group_id, null)
  self                     = try(local.egress_rules[count.index].self, null)
  description              = try(local.egress_rules[count.index].description, null)
}

