##################################
# General
##################################
variable "create" {
  description = "Controls whether to create the KMS key"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the KMS key (used in tags)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the KMS key"
  type        = map(string)
  default     = {}
}

##################################
# KMS Key Configuration
##################################
variable "description" {
  description = "The description of the KMS key"
  type        = string
  default     = null
}

variable "deletion_window_in_days" {
  description = "Waiting period before KMS key is deleted after destruction (7–30 days)"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled"
  type        = bool
  default     = true
}

variable "customer_master_key_spec" {
  description = "Specifies the type of KMS key to create"
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "key_usage" {
  description = "Defines what the key is used for: ENCRYPT_DECRYPT or SIGN_VERIFY"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "multi_region" {
  description = "Indicates whether the key is a multi-Region primary key"
  type        = bool
  default     = false
}

variable "bypass_policy_lockout_safety_check" {
  description = "Specifies whether to bypass the key policy lockout safety check"
  type        = bool
  default     = false
}

variable "policy" {
  description = "Key policy to attach to the KMS key"
  type        = string
  default     = null
}

##################################
# KMS Alias
##################################
variable "alias_name" {
  description = "Name of the alias to associate with the KMS key"
  type        = string
  default     = null
}