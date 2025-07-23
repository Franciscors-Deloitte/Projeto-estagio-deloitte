## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_iam_group.this | resource |
| aws_iam_group_membership.this | resource |
| aws_iam_group_policy_attachment.this | resource |
| aws_caller_identity.current | Data Source |
| aws_partition.current | Data Source |
| aws_iam_policy_document.iam_self_management | Data Source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_group | Whether to create IAM group | `bool` | `true` | no |
| name | Name of IAM group | `string` | `""` | no |
| path | Desired path for the IAM group | `string` | `"/"` | no |
| group_users | List of IAM users to have in an IAM group which can assume the role | `list(string)` | `[]` | no |
| policy_arns | List of IAM policy ARNs to attach to the group | `list(string)` | `[]` | no |
| aws_account_id | AWS account ID used to build ARNs (leave blank to auto-detect). | `string` | `""` | no |
| enable_mfa_enforcement | When true, add a deny statement for API calls made without MFA. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_arn | IAM group arn |
| group_users | List of IAM users in IAM group |
| group_name | IAM group name |