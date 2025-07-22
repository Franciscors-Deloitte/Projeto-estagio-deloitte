## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_cloudwatch_log_stream.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Cloudwatch log stream | `bool` | `true` | no |
| name | A name for the log stream | `string` | `null` | no |
| log_group_name | A name of the log group | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch_log_stream_name | Name of Cloudwatch log stream |
| cloudwatch_log_stream_arn | ARN of Cloudwatch log stream |