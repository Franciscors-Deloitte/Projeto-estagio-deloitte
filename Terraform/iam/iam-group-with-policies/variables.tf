variable "create_group" {
  description = "Whether to create IAM group"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of IAM group"
  type        = string
  default     = ""
}

variable "path" {
  description = "Desired path for the IAM group"
  type        = string
  default     = "/"
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  type        = list(string)
  default     = []
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the group"
  type        = list(string)
  default     = []
}

variable "aws_account_id" {
  description = "AWS account ID used to build ARNs (leave blank to auto-detect)."
  type        = string
  default     = "" 
}

variable "enable_mfa_enforcement" {
  description = "When true, add a deny statement for API calls made without MFA."
  type        = bool
  default     = false
}

