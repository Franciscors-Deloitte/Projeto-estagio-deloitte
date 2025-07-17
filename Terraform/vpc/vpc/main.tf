##################################
# Locals
##################################
locals {
  vpc_name = var.use_name_prefix ? "${var.name}-vpc" : var.name
}

##################################
# VPC
##################################
resource "aws_vpc" "this" {
  count                = var.create ? 1 : 0
  cidr_block           = var.cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = merge(var.tags, {
    Name = replace(local.vpc_name, ".", "-")
  })
}

##################################
# Subnets
##################################
resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.public_subnets : idx => subnet }

  vpc_id            = aws_vpc.this[0].id
  cidr_block        = each.value
  availability_zone = element(var.availability_zones, tonumber(each.key))
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${local.vpc_name}-public-${each.key}"
  })
}

resource "aws_subnet" "private" {
  for_each = { for idx, subnet in var.private_subnets : idx => subnet }

  vpc_id            = aws_vpc.this[0].id
  cidr_block        = each.value
  availability_zone = element(var.availability_zones, tonumber(each.key))

  tags = merge(var.tags, {
    Name = "${local.vpc_name}-private-${each.key}"
  })
}

##################################
# Internet Gateway
##################################
resource "aws_internet_gateway" "this" {
  count  = var.create ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(var.tags, {
    Name = "${local.vpc_name}-igw"
  })
}

##################################
# Route Table (Public)
##################################
resource "aws_route_table" "public" {
  count  = var.create ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }

  tags = merge(var.tags, {
    Name = "${local.vpc_name}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[0].id
}