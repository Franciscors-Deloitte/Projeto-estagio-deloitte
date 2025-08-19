## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| random_id.snapshot_identifier | resource |
| aws_db_instance.this | resource |
| aws_partition.current | Data Source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the RDS instance | `bool` | `true` | no |
| identifier | Name of the RDS instance | `string` | `n/a` | yes |
| use_identifier_prefix | Whether to use identifier as a prefix | `bool` | `false` | no |
| engine | Database engine to use (e.g., `mysql`, `postgres`) | `string` | `"postgres"` | no |
| engine_version | Database engine version | `string` | `"14.5"` | no |
| engine_lifecycle_support | Engine lifecycle support flag (`default` / `custom` / `open-source-rds-extended-support-disabled`) | `string` | `"open-source-rds-extended-support-disabled"` | no |
| instance_class | RDS instance type (e.g., `db.t3.micro`) | `string` | `n/a` | yes |
| allocated_storage | Allocated storage in GiB | `number` | `20` | no |
| storage_type | Storage type (`standard`, `gp2`, `io1`, etc.) | `string` | `"gp2"` | no |
| db_name | Database name | `string` | `null` | no |
| username | Master username | `string` | `null` | no |
| password | Master password | `string` | `null` | no |
| port | Database port | `number` | `5432` | no |
| replicate_source_db | If set, creates a read replica of the specified source | `string` | `null` | no |
| multi_az | Enable Multi-AZ deployment | `bool` | `false` | no |
| publicly_accessible | Whether the instance is publicly accessible | `bool` | `false` | no |
| db_subnet_group_name | Name of the DB subnet group | `string` | `null` | no |
| vpc_security_group_ids | List of VPC security group IDs | `list(string)` | `[]` | no |
| parameter_group_name | Name of the DB parameter group | `string` | `null` | no |
| option_group_name | Name of the DB option group | `string` | `null` | no |
| monitoring_interval | Enhanced Monitoring interval in seconds (`0` to disable) | `number` | `0` | no |
| monitoring_role_arn | IAM role ARN for Enhanced Monitoring | `string` | `null` | no |
| enabled_cloudwatch_logs_exports | Log types to export to CloudWatch | `list(string)` | `[]` | no |
| performance_insights_enabled | Whether Performance Insights are enabled | `bool` | `false` | no |
| performance_insights_kms_key_id | KMS key ID/ARN for Performance Insights | `string` | `null` | no |
| backup_retention_period | Days to retain automated backups | `number` | `7` | no |
| backup_window | Preferred backup window | `string` | `null` | no |
| maintenance_window | Preferred maintenance window | `string` | `null` | no |
| skip_final_snapshot | Skip final snapshot on instance deletion | `bool` | `false` | no |
| final_snapshot_identifier_prefix | Prefix for the final snapshot name (if not skipped) | `string` | `"final"` | no |
| snapshot_identifier | Custom snapshot identifier (used with `random_id`) | `string` | `null` | no |
| deletion_protection | Enable deletion protection | `bool` | `false` | no |
| apply_immediately | Apply modifications immediately | `bool` | `false` | no |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_identifier | The RDS instance identifier |
| db_instance_arn | The ARN of the RDS instance |
| db_instance_endpoint | The connection endpoint |
| db_instance_address | The address of the RDS instance |
| db_instance_port | The database port |
| db_instance_status | The RDS instance status |