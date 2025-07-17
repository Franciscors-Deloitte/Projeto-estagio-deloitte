##################################
# General
##################################

variable "create" {
  description = "Whether to create the VPC resources"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "use_name_prefix" {
  description = "Whether to use the name as prefix"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

##################################
# VPC Configuration
##################################

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

##################################
# Subnets
##################################

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = []
}