# General
variable "create" {
  description = "Controls whether to create the CloudTrail resource"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the CloudTrail"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

# S3
variable "s3_bucket_name" {
  description = "Name of the S3 bucket where CloudTrail will deliver logs"
  type        = string
}

variable "s3_key_prefix" {
  description = "Prefix for S3 object names"
  type        = string
  default     = null
}

# CloudTrail configuration
variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Specifies whether the trail is created in all regions"
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  description = "Specifies whether log file integrity validation is enabled"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enables logging for the trail"
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "Specifies whether the trail is an AWS Organizations trail"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key ARN to encrypt CloudTrail logs"
  type        = string
  default     = null
}

# CloudWatch (optional)
variable "enable_cloudwatch_logs" {
  description = "Whether to enable integration with CloudWatch Logs"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_role_arn" {
  description = "IAM role ARN for CloudTrail to publish logs to CloudWatch"
  type        = string
  default     = null
}

variable "cloudwatch_logs_group_arn" {
  description = "ARN of the CloudWatch Logs log group to which CloudTrail will deliver logs"
  type        = string
  default     = null
}