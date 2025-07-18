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
  description = "Map of Lambda notification configurations"
  type        = any
  default     = {}
}

variable "sqs_notifications" {
  description = "Map of SQS notification configurations"
  type        = any
  default     = {}
}

variable "sns_notifications" {
  description = "Map of SNS notification configurations"
  type        = any
  default     = {}
}