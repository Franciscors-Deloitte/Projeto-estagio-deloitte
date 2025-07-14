#############################
# Locals
#############################
locals {
  len_public_subnets      = max(length(var.public_subnets), length(var.public_subnet_ipv6_prefixes))
  len_private_subnets     = max(length(var.private_subnets), length(var.private_subnet_ipv6_prefixes))
  len_database_subnets    = max(length(var.database_subnets), length(var.database_subnet_ipv6_prefixes))
  len_elasticache_subnets = max(length(var.elasticache_subnets), length(var.elasticache_subnet_ipv6_prefixes))
  len_redshift_subnets    = max(length(var.redshift_subnets), length(var.redshift_subnet_ipv6_prefixes))

  endpoints = { for k, v in var.endpoints : k => v if var.create && try(v.create, true) }
}

#############################
# VPC
#############################
resource "aws_vpc" "this" {
  count                = var.create ? 1 : 0
  cidr_block           = var.cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge(var.tags, { Name = var.name })
}

#############################
# Subnets
#############################
resource "aws_subnet" "public" {
  count             = local.len_public_subnets
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags              = merge(var.tags, { Name = "${var.name}-public-${count.index}" })
}

#############################
# Internet Gateway
#############################
resource "aws_internet_gateway" "this" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags   = merge(var.tags, { Name = "${var.name}-igw" })
}

#############################
# NAT Gateway + EIP
#############################
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? local.len_public_subnets : 0
  vpc   = true
  tags  = merge(var.tags, { Name = "${var.name}-eip-${count.index}" })
}

resource "aws_nat_gateway" "this" {
  count         = var.enable_nat_gateway ? local.len_public_subnets : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags          = merge(var.tags, { Name = "${var.name}-nat-${count.index}" })
}

#############################
# Route Tables
#############################
resource "aws_route_table" "public" {
  count  = var.create ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags   = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route" "public_internet" {
  count                  = var.create_igw ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public" {
  count          = local.len_public_subnets
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

#############################
# VPC Endpoints
#############################
data "aws_vpc_endpoint_service" "this" {
  for_each = local.endpoints

  service      = try(each.value.service, null)
  service_name = try(each.value.service_name, null)

  filter {
    name   = "service-type"
    values = [try(each.value.service_type, "Interface")]
  }
}

resource "aws_vpc_endpoint" "this" {
  for_each            = local.endpoints
  vpc_id              = aws_vpc.this[0].id
  vpc_endpoint_type   = try(each.value.vpc_endpoint_type, "Interface")
  service_name        = coalesce(data.aws_vpc_endpoint_service.this[each.key].service_name, each.value.service_name)
  private_dns_enabled = try(each.value.private_dns_enabled, null)
  policy              = try(each.value.policy, null)
  route_table_ids     = try(each.value.route_table_ids, null)
  subnet_ids          = try(each.value.subnet_ids, null)
  security_group_ids  = try(each.value.security_group_ids, null)
  tags                = merge(var.tags, try(each.value.tags, {}))
}
