variable "create" {
  description = "Determines whether resources will be created"
  type        = bool
  default     = true
}

variable "endpoints" {
  description = "Map of interface and/or gateway endpoints and their configurations"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = []
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "create_igw" {
  description = "Whether to create an Internet Gateway"
  type        = bool
  default     = true
}

variable "database_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDR prefixes for database subnets"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "List of database subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "elasticache_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDR prefixes for ElastiCache subnets"
  type        = list(string)
  default     = []
}

variable "elasticache_subnets" {
  description = "List of ElastiCache subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT Gateway(s)"
  type        = bool
  default     = false
}

variable "name" {
  description = "Base name used for resources"
  type        = string
  default     = ""
}

variable "private_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDR prefixes for private subnets"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "public_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDR prefixes for public subnets"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "redshift_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDR prefixes for Redshift subnets"
  type        = list(string)
  default     = []
}

variable "redshift_subnets" {
  description = "List of Redshift subnet CIDRs"
  type        = list(string)
  default     = []
}