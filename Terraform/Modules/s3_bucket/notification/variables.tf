variable "create" {
  description = "Controls whether resources are created"
  type        = bool
  default     = true
}

variable "bucket" {
  description = "Name of the bucket to configure notifications for"
  type        = string
}

variable "eventbridge" {
  description = "Enables Amazon EventBridge notifications"
  type        = bool
  default     = false
}

variable "lambda_notifications" {
  description = "Map of Lambda function notifications and their configuration"
  type = map(object({
    function_arn  = string
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = {}
}

variable "sqs_notifications" {
  description = "Map of SQS queue notifications and their configuration"
  type = map(object({
    queue_arn     = string
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = {}
}

variable "sns_notifications" {
  description = "Map of SNS topic notifications and their configuration"
  type = map(object({
    topic_arn     = string
    events        = list(string)
    filter_prefix = optional(string)
    filter_suffix = optional(string)
  }))
  default = {}
}