# General
variable "create" {
  description = "Whether to create the WAFv2 Web ACL"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the WAFv2 Web ACL"
  type        = string
}

variable "description" {
  description = "Description of the Web ACL"
  type        = string
  default     = null
}

variable "scope" {
  description = "Specifies whether this is for CloudFront (CLOUDFRONT) or regional (REGIONAL) resources"
  type        = string
  default     = "REGIONAL"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

# Association
variable "associate_with_resource" {
  description = "Whether to associate the Web ACL with a resource (ALB, CloudFront, etc.)"
  type        = bool
  default     = false
}

variable "resource_arn" {
  description = "The ARN of the resource to associate with the Web ACL"
  type        = string
  default     = null
}