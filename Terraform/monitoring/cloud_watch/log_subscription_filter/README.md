## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_cloudwatch_log_subscription_filter.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Cloudwatch log stream | `bool` | `true` | no |
| name | A name for the log stream | `string` | `null` | no |
| destination_arn | The ARN of the destination to deliver matching log events to. Kinesis stream or Lambda function ARN | `string` | `null` | no |
| filter_pattern | A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Use empty string to match everything | `string` | `""` | no |
| log_group_name | The name of the log group to associate the subscription filter with | `string` | `null` | no |
| role_arn | The ARN of an IAM role that grants Amazon CloudWatch Logs permissions to deliver ingested log events to the destination | `string` | `null` | no |
| distribution | The method used to distribute log data to the destination. By default log data is grouped by log stream, but the grouping can be set to random for a more even distribution | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch_log_subscription_filter_name | Log subscription filter name |