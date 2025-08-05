variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "create_sg" {
  description = "Whether to create security group"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of security group - not required if create_sg is false"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create"
  type = list(object({
    protocol                  = string
    from_port                 = number
    to_port                   = number
    cidr_blocks               = optional(list(string), [])
    ipv6_cidr_blocks          = optional(list(string), [])
    prefix_list_ids           = optional(list(string), [])
    source_security_group_id  = optional(string)
    self                      = optional(bool)
    description               = optional(string)
  }))
  default = []
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create"
  type = list(object({
    protocol                  = string
    from_port                 = number
    to_port                   = number
    cidr_blocks               = optional(list(string), [])
    ipv6_cidr_blocks          = optional(list(string), [])
    prefix_list_ids           = optional(list(string), [])
    source_security_group_id  = optional(string)
    self                      = optional(bool)
    description               = optional(string)
  }))
  default = []
}