## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_s3_bucket_notification.this | resource |
| aws_partition.this | Data Source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether resources are created | `bool` | `true` | no |
| bucket | Name of the bucket to configure notifications for | `string` | `n/a` | yes |
| eventbridge | Enables Amazon EventBridge notifications | `bool` | `false` | no |
| lambda_notifications | Map of Lambda function notifications and their configuration | `map(object({` *function_arn = string* `,` *filter_prefix = string* `,` *filter_suffix = string* `}))` | `n/a` | yes |
| sqs_notifications | Map of SQS queue notifications and their configuration | `map(object({` *queue_arn = string* `,` *filter_prefix = string* `,` *filter_suffix = string* `}))` | `n/a` | yes |
| sns_notifications | Map of SNS topic notifications and their configuration | `map(object({` *topic_arn = string* `,` *filter_prefix = string* `,` *filter_suffix = string* `}))` | `n/a` | yes |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket_notification_id | ID of S3 bucket |