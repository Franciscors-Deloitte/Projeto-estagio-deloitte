##################################
# General Configuration
##################################

variable "create" {
  description = "Whether to create the RDS instance"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

##################################
# DB Instance Settings
##################################

variable "allocated_storage" {
  description = "The amount of allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "One of standard, gp2, or io1"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = null
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

##################################
# Networking and Security
##################################

variable "multi_az" {
  description = "If true, create a multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Subnet group to associate with the RDS instance"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}

variable "option_group_name" {
  description = "Name of the DB option group to associate"
  type        = string
  default     = null
}

##################################
# Backup and Maintenance
##################################

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = null
}

##################################
# Final Snapshot and Deletion
##################################

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final DB snapshot before deletion"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}

##################################
# Monitoring and Performance
##################################

variable "apply_immediately" {
  description = "Whether to apply changes immediately"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between enhanced monitoring metrics"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "ARN of the IAM role used for enhanced monitoring"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN of the KMS key for Performance Insights"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to export to CloudWatch"
  type        = list(string)
  default     = []
}

##################################
# Tags
##################################

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}