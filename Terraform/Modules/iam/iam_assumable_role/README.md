## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_iam_instance_profile.this | resource |
| aws_iam_role.this | resource |
| aws_iam_role_policy.inline | resource |
| aws_iam_role_policy_attachment.admin | resource |
| aws_iam_role_policy_attachment.custom | resource |
| aws_iam_role_policy_attachment.poweruser | resource |
| aws_iam_role_policy_attachment.readonly | resource |
| aws_caller_identity.current | Data Source |
| aws_iam_policy_document.assume_role | Data Source |
| aws_iam_policy_document.assume_role_with_mfa | Data Source |
| aws_iam_policy_document.inline | Data Source |
| aws_partition.current | Data Source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow_self_assume_role | Allow the role to assume itself (chaining) | `bool` | `false` | no |
| create_custom_role_trust_policy | Whether to create the trust policy in this module (set to false if you provide `custom_role_trust_policy`) | `bool` | `true` | no |
| create_instance_profile | Whether to create an instance profile | `bool` | `false` | no |
| create_role | Whether to create a role | `bool` | `false` | no |
| custom_role_trust_policy | Custom trust policy JSON (used when `create_custom_role_trust_policy = false`) | `string` | `""` | no |
| force_detach_policies | Detach policies from the role on destroy | `bool` | `false` | no |
| inline_policy_statements | Inline policy statements to embed in the role | `list(object({ sid = optional(string), effect = optional(string, "Allow"), actions = list(string), resources = list(string) }))` | `[]` | no |
| max_session_duration | Maximum session duration (seconds) | `number` | `3600` | no |
| mfa_age | Max age of valid MFA (seconds) | `number` | `86400` | no |
| role_description | IAM role description | `string` | `null` | no |
| role_name | IAM role name | `string` | `n/a` | yes |
| role_name_prefix | IAM role name prefix | `string` | `null` | no |
| role_path | IAM role path | `string` | `"/"` | no |
| role_permissions_boundary_arn | Permissions boundary ARN | `string` | `""` | no |
| role_policy_arns | Policy ARNs to attach to the role | `list(string)` | `[]` | no |
| role_requires_mfa | Require MFA to assume the role | `bool` | `true` | no |
| role_requires_session_name | Require session name when assuming the role | `bool` | `true` | no |
| role_session_name | Default session name (usually the username) | `list(string)` | `["${aws:username}"]` | no |
| role_sts_externalid | STS ExternalId to require (when MFA not required) | `string` | `null` | no |
| tags | Tags to apply to IAM resources | `map(string)` | `{}` | no |
| trust_policy_conditions | Extra trust policy conditions | `list(object({ test = string, variable = string, values = list(string) }))` | `[]` | no |
| trusted_role_actions | Additional trusted role actions | `list(string)` | `["sts:AssumeRole", "sts:TagSession"]` | no |
| trusted_role_arns | Trusted role/user ARNs allowed to assume | `list(string)` | `[]` | no |
| trusted_role_services | AWS services allowed to assume | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam_instance_profile_arn | ARN of IAM instance profile |
| iam_instance_profile_id | IAM Instance profile ID |
| iam_instance_profile_name | Name of IAM instance profile |
| iam_instance_profile_path | Path of IAM instance profile |
| iam_role_arn | ARN of IAM role |
| iam_role_name | Name of IAM role |
| iam_role_path | Path of IAM role |
| iam_role_unique_id | Unique ID of IAM role |
| role_requires_mfa | Whether IAM role requires MFA |
| role_sts_externalid | STS ExternalId condition value for the role |