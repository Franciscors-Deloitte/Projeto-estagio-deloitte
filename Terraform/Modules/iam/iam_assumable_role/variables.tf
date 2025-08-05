variable "trusted_role_actions" {
  description = "Additional trusted role actions"
  type        = list(string)
  default     = ["sts:AssumeRole", "sts:TagSession"]
}

variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "trust_policy_conditions" {
  description = "Optional list of condition blocks for the trust relationship"
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  default = []
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = number
  default     = 86400
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = null
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = bool
  default     = true
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}


variable "custom_role_trust_policy" {
  description = "A custom role trust policy. (Only valid if create_custom_role_trust_policy = true)"
  type        = string
  default     = ""
}

variable "create_custom_role_trust_policy" {
  description = "Whether to create the trust policy document within the module (set to false if supplying your own via custom_role_trust_policy)"
  type        = bool
  default     = true
}

variable "allow_self_assume_role" {
  description = "Allow the role to assume itself (to enable chaining)"
  type        = bool
  default     = false
}

variable "inline_policy_statements" {
  description = "A list of policy statements to embed in the role policy"
  type = list(object({
    sid       = optional(string)
    effect    = optional(string, "Allow")
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}

variable "role_description" {
  description = "IAM role description"
  type        = string
  default     = null
}

variable "role_policy_arns" {
  description = "List of IAM policy ARNs to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "role_requires_session_name" {
  description = "Whether role requires session name"
  type        = bool
  default     = true
}

variable "role_session_name" {
  description = "Session name to require for assume role"
  type        = string
  default     = null
}

variable "role_sts_externalid" {
  description = "STS external ID to require for assume role"
  type        = string
  default     = null
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "role_session_name" {
  description = "role_session_name for roles which require this parameter when being assumed. By default, you need to set your own username as role_session_name"
  type        = list(string)
  default     = ["$${aws:username}"]
}