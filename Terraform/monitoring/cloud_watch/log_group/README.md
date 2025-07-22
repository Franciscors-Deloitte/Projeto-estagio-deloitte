## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_cloudwatch_log_group.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Cloudwatch log group | `bool` | `true` | no |
| name | A name for the log group | `string` | `null` | no |
| name_prefix | A name prefix for the log group | `string` | `null` | no |
| retention_in_days | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288 and 3653. | `number` | `null` | no |
| kms_key_id | The ARN of the KMS Key to use when encrypting logs | `string` | `null` | no |
| log_group_class | Specified the log class of the log group. Possible values are: STANDARD or INFREQUENT_ACCESS | `string` | `null` | no |
| skip_destroy | Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state | `bool` | `null` | no |
| tags | A map of tags to add to Cloudwatch log group | `map(string)` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch_log_group_name | Name of Cloudwatch log group |
| cloudwatch_log_group_arn | ARN of Cloudwatch log group |