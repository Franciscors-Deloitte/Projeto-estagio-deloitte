## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_cloudwatch_metric_alarm.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_metric_alarm | Whether to create the CloudWatch metric alarm | `bool` | `true` | no |
| alarm_name | The name for the alarm | `string` | `null` | yes |
| alarm_description | The description for the alarm | `string` | `null` | no |
| actions_enabled | Indicates whether or not actions should be executed during any changes to the alarm state | `bool` | `true` | no |
| alarm_actions | The list of actions to execute when this alarm transitions into an ALARM state | `list(string)` | `[]` | no |
| ok_actions | The list of actions to execute when this alarm transitions into an OK state | `list(string)` | `[]` | no |
| insufficient_data_actions | The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state | `list(string)` | `[]` | no |
| comparison_operator | The arithmetic operation to use when comparing the specified statistic and threshold | `string` | `null` | yes |
| evaluation_periods | The number of periods over which data is compared to the specified threshold | `number` | `null` | yes |
| threshold | The value against which the specified statistic is compared | `number` | `null` | yes |
| unit | The unit for the metric | `string` | `null` | no |
| datapoints_to_alarm | The number of datapoints that must be breaching to trigger the alarm | `number` | `null` | no |
| treat_missing_data | Sets how this alarm is to handle missing data points | `string` | `null` | no |
| evaluate_low_sample_count_percentiles | Used only for alarms based on percentiles | `string` | `null` | no |
| metric_name | The name for the metric associated with the alarm | `string` | `null` | no |
| namespace | The namespace for the metric associated with the alarm | `string` | `null` | no |
| period | The period in seconds over which the specified statistic is applied | `number` | `null` | no |
| statistic | The statistic to apply to the alarm's associated metric | `string` | `null` | no |
| extended_statistic | The percentile statistic for the metric associated with the alarm | `string` | `null` | no |
| dimensions | The dimensions for the alarm's associated metric | `map(string)` | `{` | no |
| tags | A map of tags to assign to the resource | `map(string)` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch_metric_alarm_arn | The ARN of the Cloudwatch metric alarm. |
| cloudwatch_metric_alarm_id | The ID of the Cloudwatch metric alarm. |