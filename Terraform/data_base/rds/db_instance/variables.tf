##################################
# Resource Control
##################################

variable "create" {
  description = "Whether to create the RDS instance"
  type        = bool
  default     = true
}

##################################
# Identifiers
##################################

variable "identifier" {
  description = "Name of the RDS instance"
  type        = string
}

variable "use_identifier_prefix" {
  description = "Whether to use identifier as a prefix"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier_prefix" {
  description = "Prefix to use for the final snapshot name if not skipped"
  type        = string
  default     = "final"
}

variable "snapshot_identifier" {
  description = "Custom snapshot identifier (used with random_id)"
  type        = string
  default     = null
}

##################################
# Database Configuration
##################################

variable "engine" {
  description = "Database engine to use (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = null
}

variable "engine_lifecycle_support" {
  description = "Set to 'default' or 'custom' if required"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "RDS instance type (e.g., db.t3.micro)"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = null
}

variable "username" {
  description = "Master username"
  type        = string
  default     = null
}

variable "password" {
  description = "Master password"
  type        = string
  default     = null
}

variable "port" {
  description = "Database port"
  type        = number
  default     = 5432
}

##################################
# Replication
##################################

variable "replicate_source_db" {
  description = "If set, creates a read replica of the specified source"
  type        = string
  default     = null
}

##################################
# Networking
##################################

variable "multi_az" {
  description = "Whether to enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether the instance is publicly accessible"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
  default     = []
}

##################################
# Configuration Groups
##################################

variable "parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
  default     = null
}

variable "option_group_name" {
  description = "Name of the DB option group"
  type        = string
  default     = null
}

##################################
# Monitoring and Logs
##################################

variable "monitoring_interval" {
  description = "Interval in seconds for Enhanced Monitoring (0 to disable)"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "ARN of the IAM role for Enhanced Monitoring"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = []
}

variable "performance_insights_enabled" {
  description = "Whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "KMS key ID for Performance Insights"
  type        = string
  default     = null
}

##################################
# Maintenance and Backups
##################################

variable "backup_retention_period" {
  description = "Days to retain automated backups"
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
  description = "Skip final snapshot on instance deletion"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection on the DB instance"
  type        = bool
  default     = false
}

##################################
# Misc
##################################

variable "apply_immediately" {
  description = "Whether to apply modifications immediately"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}