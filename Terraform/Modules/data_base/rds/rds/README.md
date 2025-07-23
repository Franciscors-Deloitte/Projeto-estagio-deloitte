## Modules

| Name | Source | Version |
|------|--------|---------|
| db_instance | ./db_instance | n/a |

## Resources

No Resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the RDS instance | `bool` | `true` | no |
| identifier | The name of the RDS instance | `string` | `null` | yes |
| allocated_storage | The amount of allocated storage in gigabytes | `number` | `20` | no |
| storage_type | One of standard, gp2, or io1 | `string` | `"gp2"` | no |
| engine | The database engine to use | `string` | `null` | yes |
| engine_version | The version of the database engine | `string` | `null` | no |
| instance_class | The instance type of the RDS instance | `string` | `null` | yes |
| db_name | Name of the database to create | `string` | `null` | no |
| username | Username for the master DB user | `string` | `null` | no |
| password | Password for the master DB user | `string` | `null` | no |
| port | The port on which the DB accepts connections | `number` | `5432` | no |
| multi_az | If true, create a multi-AZ deployment | `bool` | `false` | no |
| publicly_accessible | Bool to control if instance is publicly accessible | `bool` | `false` | no |
| db_subnet_group_name | Subnet group to associate with the RDS instance | `string` | `null` | no |
| vpc_security_group_ids | List of VPC security groups to associate | `list(string)` | `[]` | no |
| parameter_group_name | Name of the DB parameter group to associate | `string` | `null` | no |
| option_group_name | Name of the DB option group to associate | `string` | `null` | no |
| backup_retention_period | The days to retain backups for | `number` | `7` | no |
| backup_window | Preferred backup window | `string` | `null` | no |
| maintenance_window | Preferred maintenance window | `string` | `null` | no |
| skip_final_snapshot | Whether to skip taking a final DB snapshot before deletion | `bool` | `false` | no |
| final_snapshot_identifier | The name of your final DB snapshot | `string` | `null` | no |
| deletion_protection | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| apply_immediately | Whether to apply changes immediately | `bool` | `false` | no |
| monitoring_interval | The interval, in seconds, between enhanced monitoring metrics | `number` | `0` | no |
| monitoring_role_arn | ARN of the IAM role used for enhanced monitoring | `string` | `null` | no |
| performance_insights_enabled | Specifies whether Performance Insights is enabled | `bool` | `false` | no |
| performance_insights_kms_key_id | The ARN of the KMS key for Performance Insights | `string` | `null` | no |
| enabled_cloudwatch_logs_exports | Set of log types to export to CloudWatch | `list(string)` | `[]` | no |
| tags | A map of tags to assign to resources | `map(string)` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_identifier | The RDS instance identifier |
| db_instance_arn | The ARN of the RDS instance |
| db_instance_endpoint | The connection endpoint |
| db_instance_address | The address of the RDS instance |
| db_instance_port | The database port |
| db_instance_status | The RDS instance status |