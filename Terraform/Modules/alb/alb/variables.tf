##################################
# General
##################################
variable "create" {
  description = "Whether to create the ALB"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {}
}

##################################
# ALB Configuration
##################################
variable "internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Valid values are 'application' or 'network'"
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "List of subnet IDs to attach to the ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
  default     = []
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the ALB. Valid values: 'ipv4' or 'dualstack'"
  type        = string
  default     = "ipv4"
}

variable "idle_timeout" {
  description = "The time (in seconds) that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled"
  type        = bool
  default     = false
}

##################################
# Access Logs
##################################
variable "access_logs" {
  description = "Configuration for access logs: bucket, prefix, and enabled"
  type = object({
    bucket  = string
    prefix  = optional(string)
    enabled = optional(bool)
  })
  default = {}
}