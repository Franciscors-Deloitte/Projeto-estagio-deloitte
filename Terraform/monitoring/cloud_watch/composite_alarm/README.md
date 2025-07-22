## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_cloudwatch_composite_alarm.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Cloudwatch composite alarm | `bool` | `true` | no |
| alarm_name | The descriptive name for the composite alarm. This name must be unique within the region. | `string` | `null` | no |
| alarm_description | The description for the composite alarm. | `string` | `null` | no |
| actions_enabled | Indicates whether or not actions should be executed during any changes to the composite alarm's state. Defaults to true. | `bool` | `true` | no |
| actions_suppressor | A map of actions suppressor alarm configurations. | `map(any)` | `{` | no |
| alarm_actions | The set of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN). Up to 5 actions are allowed. | `list(string)` | `null` | no |
| insufficient_data_actions | The set of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN). Up to 5 actions are allowed. | `list(string)` | `null` | no |
| ok_actions | The set of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN). Up to 5 actions are allowed. | `list(string)` | `null` | no |
| alarm_rule | An expression that specifies which other alarms are to be evaluated to determine this composite alarm's state. The maximum length is 10240 characters. | `string` | `null` | no |
| tags | A mapping of tags to assign to all resources | `map(string)` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch_composite_alarm_arn | The ARN of the Cloudwatch composite alarm. |
| cloudwatch_composite_alarm_id | The ID of the Cloudwatch composite alarm. |