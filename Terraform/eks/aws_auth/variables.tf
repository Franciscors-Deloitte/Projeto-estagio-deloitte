##################################
# Module control
##################################

variable "create" {
  description = "Whether to create the aws-auth ConfigMap"
  type        = bool
  default     = true
}

variable "create_aws_auth_configmap" {
  description = "Control creation of aws-auth ConfigMap"
  type        = bool
  default     = true
}

##################################
# AWS Auth Configuration
##################################

variable "aws_auth_roles" {
  description = "List of role mappings to add to the aws-auth ConfigMap"
  type        = any
  default     = []
}

variable "aws_auth_users" {
  description = "List of user mappings to add to the aws-auth ConfigMap"
  type        = any
  default     = []
}

variable "aws_auth_accounts" {
  description = "List of AWS account IDs to add to the aws-auth ConfigMap"
  type        = list(string)
  default     = []
}

##################################
# Metadata labels
##################################

variable "labels" {
  description = "Labels to add to the aws-auth ConfigMap metadata"
  type        = map(string)
  default     = {}
}