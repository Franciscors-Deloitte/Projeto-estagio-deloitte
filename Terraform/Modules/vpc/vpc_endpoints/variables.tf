##################################
# General
##################################

variable "vpc_id" {
  description = "The ID of the VPC to associate with the endpoints"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all VPC endpoints"
  type        = map(string)
  default     = {}
}

##################################
# Endpoints
##################################

variable "endpoints" {
  description = "Map of VPC endpoint configurations"
  type = map(object({
    create                = bool
    service               = string
    type                  = string
    subnet_ids            = optional(list(string))
    security_group_ids    = optional(list(string))
    private_dns_enabled   = optional(bool)
  }))
  default = {}
}

##################################
# Defaults (optional inputs)
##################################

variable "subnet_ids" {
  description = "Default list of subnet IDs to use when not specified per endpoint"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Default list of security group IDs to use when not specified per endpoint"
  type        = list(string)
  default     = []
}