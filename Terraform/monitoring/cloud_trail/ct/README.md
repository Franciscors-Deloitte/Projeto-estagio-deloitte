## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_cloudtrail.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the CloudTrail resource | `bool` | `true` | no |
| name | Name of the CloudTrail | `string` | `null` | yes |
| tags | Tags to apply to the resources | `map(string)` | `{` | no |
| s3_bucket_name | Name of the S3 bucket where CloudTrail will deliver logs | `string` | `null` | yes |
| s3_key_prefix | Prefix for S3 object names | `string` | `null` | no |
| include_global_service_events | Specifies whether the trail is publishing events from global services such as IAM | `bool` | `true` | no |
| is_multi_region_trail | Specifies whether the trail is created in all regions | `bool` | `true` | no |
| enable_log_file_validation | Specifies whether log file integrity validation is enabled | `bool` | `true` | no |
| enable_logging | Enables logging for the trail | `bool` | `true` | no |
| is_organization_trail | Specifies whether the trail is an AWS Organizations trail | `bool` | `false` | no |
| kms_key_id | KMS key ARN to encrypt CloudTrail logs | `string` | `null` | no |
| enable_cloudwatch_logs | Whether to enable integration with CloudWatch Logs | `bool` | `false` | no |
| cloudwatch_logs_role_arn | IAM role ARN for CloudTrail to publish logs to CloudWatch | `string` | `null` | no |
| cloudwatch_logs_group_arn | ARN of the CloudWatch Logs log group to which CloudTrail will deliver logs | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudtrail_id | The name of the CloudTrail |
| cloudtrail_arn | The ARN of the CloudTrail |
| cloudtrail_home_region | The region in which the trail was created |