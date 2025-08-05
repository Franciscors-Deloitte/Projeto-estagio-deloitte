##################################
# General
##################################

variable "create" {
  description = "Controls if RDS resources should be created"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "use_identifier_prefix" {
  description = "Determines whether to use `identifier` as is or create a unique name beginning with the `identifier` as the prefix"
  type        = bool
  default     = false
}

##################################
# Database Configuration
##################################

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "14.5"
}

variable "engine_lifecycle_support" {
  description = "Enable or disable support for major version upgrades"
  type        = string
  default     = "open-source-rds-extended-support-disabled"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

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

variable "db_name" {
  description = "The name of the database to create"
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
  sensitive   = true
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

##################################
# Replication
##################################

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this DB as the source"
  type        = string
  default     = null
}

##################################
# Networking
##################################

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to assign to the instance"
  type        = list(string)
  default     = []
}

##################################
# Configuration Groups
##################################

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
# Backups and Maintenance
##################################

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = null
}

##################################
# Deletion and Snapshots
##################################

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier_prefix" {
  description = "The name which is prefixed to the final snapshot on DB deletion"
  type        = string
  default     = "final"
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

##################################
# Monitoring and Logging
##################################

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval (in seconds) between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to use with Performance Insights"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch. If omitted, no logs will be exported"
  type        = list(string)
  default     = []
}

##################################
# Tags
##################################

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}