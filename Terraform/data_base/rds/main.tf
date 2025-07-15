resource "aws_db_instance" "this" {
  count = var.create ? 1 : 0

  identifier               = var.identifier
  allocated_storage        = var.allocated_storage
  storage_type             = var.storage_type
  engine                   = var.engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  db_name                     = var.db_name
  username                 = var.username
  password                 = var.password
  port                     = var.port
  multi_az                 = var.multi_az
  publicly_accessible      = var.publicly_accessible
  db_subnet_group_name     = var.db_subnet_group_name
  vpc_security_group_ids   = var.vpc_security_group_ids
  parameter_group_name     = var.parameter_group_name
  option_group_name        = var.option_group_name
  backup_retention_period  = var.backup_retention_period
  backup_window            = var.backup_window
  maintenance_window       = var.maintenance_window
  skip_final_snapshot      = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  deletion_protection      = var.deletion_protection
  apply_immediately        = var.apply_immediately
  storage_encrypted        = var.storage_encrypted
  kms_key_id               = var.kms_key_id

  tags = merge(var.tags, {
    Name = replace(var.identifier, ".", "-")
  })
}