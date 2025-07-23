##################################
# General
##################################

variable "create" {
  description = "Whether to create the API Gateway"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway"
  type        = string
  default     = ""
}

variable "protocol_type" {
  description = "Type of API Gateway protocol. Valid values: HTTP or WEBSOCKET"
  type        = string
  default     = "HTTP"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

##################################
# CORS
##################################

variable "cors_configuration" {
  description = "CORS configuration for the API"
  type = object({
    allow_credentials = bool
    allow_headers     = list(string)
    allow_methods     = list(string)
    allow_origins     = list(string)
    expose_headers    = list(string)
    max_age           = number
  })
  default = null
}

##################################
# Stage
##################################

variable "stage_name" {
  description = "Name of the deployment stage (e.g., prod, dev)"
  type        = string
  default     = "prod"
}

variable "auto_deploy" {
  description = "Whether to auto-deploy the API when changes are made"
  type        = bool
  default     = true
}

variable "access_log_destination_arn" {
  description = "ARN of the CloudWatch Logs group for access logging"
  type        = string
  default     = null
}

variable "access_log_format" {
  description = "Format for API access logs"
  type        = string
  default     = null
}

variable "logging_level" {
  description = "Logging level for the stage. Valid values: INFO, ERROR, OFF"
  type        = string
  default     = "INFO"
}

variable "throttling_burst_limit" {
  description = "Throttling burst limit for the default route"
  type        = number
  default     = null
}

variable "throttling_rate_limit" {
  description = "Throttling rate limit (requests per second) for the default route"
  type        = number
  default     = null
}

##################################
# Routes and Integrations
##################################

variable "create_routes_and_integrations" {
  description = "Whether to create API routes and integrations"
  type        = bool
  default     = true
}

variable "routes" {
  description = "List of routes and integration configuration"
  type = list(object({
    route_key              = string
    integration_type       = string
    integration_uri        = string
    integration_method     = string
    payload_format_version = string
    timeout_milliseconds   = optional(number)
  }))
  default = []
}

variable "body" {
  description = "OpenAPI specification body to import (for HTTP APIs only)"
  type        = string
  default     = null
}

variable "api_key_selection_expression" {
  description = "The API key selection expression for WebSocket APIs"
  type        = string
  default     = null
}