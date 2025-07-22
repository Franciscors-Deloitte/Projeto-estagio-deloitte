## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_iam_policy.policy | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_policy | Whether to create the IAM policy | `bool` | `true` | no |
| name | The name of the policy | `string` | `null` | no |
| name_prefix | IAM policy name prefix | `string` | `null` | no |
| path | The path of the policy in IAM | `string` | `"/"` | no |
| description | The description of the policy | `string` | `"IAM Policy"` | no |
| policy | The path of the policy in IAM (tpl file) | `string` | `""` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The policy's ID |
| arn | The ARN assigned by AWS to this policy |
| description | The description of the policy |
| name | The name of the policy |
| path | The path of the policy in IAM |
| policy | The policy document |