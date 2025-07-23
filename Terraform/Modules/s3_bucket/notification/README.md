## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_partition.this | Data Source |
| aws_s3_bucket_notification.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether resources are created | `bool` | `true` | no |
| bucket | Name of the bucket to configure notifications for | `string` | `null` | yes |
| eventbridge | Enables Amazon EventBridge notifications | `bool` | `false` | no |
| lambda_notifications | Map of Lambda notification configurations | `any` | `{` | no |
| sqs_notifications | Map of SQS notification configurations | `any` | `{` | no |
| sns_notifications | Map of SNS notification configurations | `any` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket_notification_id | ID of S3 bucket |