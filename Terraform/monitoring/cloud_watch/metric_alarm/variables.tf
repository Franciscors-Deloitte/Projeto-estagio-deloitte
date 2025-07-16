variable "create_metric_alarm" {
  description = "Whether to create the CloudWatch metric alarm"
  type        = bool
  default     = true
}

variable "alarm_name" {
  description = "The name for the alarm"
  type        = string
}

variable "alarm_description" {
  description = "The description for the alarm"
  type        = string
  default     = null
}

variable "actions_enabled" {
  description = "Indicates whether or not actions should be executed during any changes to the alarm state"
  type        = bool
  default     = true
}

variable "alarm_actions" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "The list of actions to execute when this alarm transitions into an OK state"
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state"
  type        = list(string)
  default     = []
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified statistic and threshold"
  type        = string
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = number
}

variable "threshold" {
  description = "The value against which the specified statistic is compared"
  type        = number
}

variable "unit" {
  description = "The unit for the metric"
  type        = string
  default     = null
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints that must be breaching to trigger the alarm"
  type        = number
  default     = null
}

variable "treat_missing_data" {
  description = "Sets how this alarm is to handle missing data points"
  type        = string
  default     = null
}

variable "evaluate_low_sample_count_percentiles" {
  description = "Used only for alarms based on percentiles"
  type        = string
  default     = null
}

variable "metric_name" {
  description = "The name for the metric associated with the alarm"
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace for the metric associated with the alarm"
  type        = string
  default     = null
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = number
  default     = null
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric"
  type        = string
  default     = null
}

variable "extended_statistic" {
  description = "The percentile statistic for the metric associated with the alarm"
  type        = string
  default     = null
}

variable "dimensions" {
  description = "The dimensions for the alarm's associated metric"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}