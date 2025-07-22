## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_partition.current | Data Source |
| random_id.snapshot_identifier | resource |
| aws_db_instance.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the RDS instance | `bool` | `true` | no |
| identifier | Name of the RDS instance | `string` | `null` | yes |
| use_identifier_prefix | Whether to use identifier as a prefix | `bool` | `false` | no |
| final_snapshot_identifier_prefix | Prefix to use for the final snapshot name if not skipped | `string` | `"final"` | no |
| snapshot_identifier | Custom snapshot identifier (used with random_id) | `string` | `null` | no |
| engine | Database engine to use (e.g., mysql, postgres) | `string` | `null` | yes |
| engine_version | Database engine version | `string` | `null` | no |
| engine_lifecycle_support | Set to 'default' or 'custom' if required | `string` | `null` | no |
| instance_class | RDS instance type (e.g., db.t3.micro) | `string` | `null` | yes |
| db_name | Database name | `string` | `null` | no |
| username | Master username | `string` | `null` | no |
| password | Master password | `string` | `null` | no |
| port | Database port | `number` | `5432` | no |
| replicate_source_db | If set, creates a read replica of the specified source | `string` | `null` | no |
| multi_az | Whether to enable Multi-AZ deployment | `bool` | `false` | no |
| publicly_accessible | Whether the instance is publicly accessible | `bool` | `false` | no |
| db_subnet_group_name | Name of the DB subnet group | `string` | `null` | no |
| vpc_security_group_ids | List of VPC security group IDs | `list(string)` | `[]` | no |
| parameter_group_name | Name of the DB parameter group | `string` | `null` | no |
| option_group_name | Name of the DB option group | `string` | `null` | no |
| monitoring_interval | Interval in seconds for Enhanced Monitoring (0 to disable) | `number` | `0` | no |
| monitoring_role_arn | ARN of the IAM role for Enhanced Monitoring | `string` | `null` | no |
| enabled_cloudwatch_logs_exports | List of log types to export to CloudWatch | `list(string)` | `[]` | no |
| performance_insights_enabled | Whether Performance Insights are enabled | `bool` | `false` | no |
| performance_insights_kms_key_id | KMS key ID for Performance Insights | `string` | `null` | no |
| backup_retention_period | Days to retain automated backups | `number` | `7` | no |
| backup_window | Preferred backup window | `string` | `null` | no |
| maintenance_window | Preferred maintenance window | `string` | `null` | no |
| skip_final_snapshot | Skip final snapshot on instance deletion | `bool` | `false` | no |
| deletion_protection | Enable deletion protection on the DB instance | `bool` | `false` | no |
| apply_immediately | Whether to apply modifications immediately | `bool` | `false` | no |
| tags | Tags to apply to all resources | `map(string)` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_identifier | The RDS instance identifier |
| db_instance_arn | The ARN of the RDS instance |
| db_instance_endpoint | The connection endpoint |
| db_instance_address | The address of the RDS instance |
| db_instance_port | The database port |
| db_instance_status | The RDS instance status |