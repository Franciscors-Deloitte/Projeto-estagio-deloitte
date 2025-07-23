##################################
# Locals
##################################

locals {
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.final_snapshot_identifier_prefix}-${var.identifier}-${try(random_id.snapshot_identifier[0].hex, "")}"

  identifier        = var.use_identifier_prefix ? null : var.identifier
  identifier_prefix = var.use_identifier_prefix ? "${var.identifier}-" : null

  is_replica = var.replicate_source_db != null
}

##################################
# Partition
##################################

data "aws_partition" "current" {}

##################################
# Final Snapshot Random ID
##################################

resource "random_id" "snapshot_identifier" {
  count = var.create && !var.skip_final_snapshot ? 1 : 0

  keepers = {
    id                  = var.identifier
    snapshot_identifier = var.snapshot_identifier
  }

  byte_length = 4
}

##################################
# RDS Instance
##################################

resource "aws_db_instance" "this" {
  count = var.create ? 1 : 0

  identifier             = local.identifier
  identifier_prefix      = local.identifier_prefix
  replicate_source_db    = var.replicate_source_db

  engine                 = local.is_replica ? null : var.engine
  engine_version         = var.engine_version
  engine_lifecycle_support = var.engine_lifecycle_support
  instance_class         = var.instance_class

  db_name                = var.db_name
  username               = local.is_replica ? null : var.username
  password               = local.is_replica ? null : var.password
  port                   = var.port

  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  parameter_group_name   = var.parameter_group_name
  option_group_name      = var.option_group_name

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier

  deletion_protection       = var.deletion_protection
  apply_immediately         = var.apply_immediately

  monitoring_interval       = var.monitoring_interval
  monitoring_role_arn       = var.monitoring_role_arn

  performance_insights_enabled     = var.performance_insights_enabled
  performance_insights_kms_key_id  = var.performance_insights_kms_key_id
  enabled_cloudwatch_logs_exports  = var.enabled_cloudwatch_logs_exports

  tags = merge(var.tags, {
    Name = replace(var.identifier, ".", "-")
  })
}