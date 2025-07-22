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
| admin_role_policy_arn | Policy ARN to use for admin role | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| allow_self_assume_role | Determines whether to allow the role to be assume itself | `bool` | `false` | no |
| attach_admin_policy | Whether to attach an admin policy to a role | `bool` | `false` | no |
| attach_poweruser_policy | Whether to attach a poweruser policy to a role | `bool` | `false` | no |
| attach_readonly_policy | Whether to attach a readonly policy to a role | `bool` | `false` | no |
| create_custom_role_trust_policy | Whether to create a custom_role_trust_policy | `bool` | `false` | no |
| create_instance_profile | Whether to create an instance profile | `bool` | `false` | no |
| create_role | Whether to create a role | `bool` | `false` | no |
| custom_role_policy_arns | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| custom_role_trust_policy | A custom role trust policy (requires create_custom_role_trust_policy = true) | `string` | `""` | no |
| force_detach_policies | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| inline_policy_statements | List of inline policy statements to attach to IAM role | `any` | `[]` | no |
| max_session_duration | Max CLI/API session duration in seconds (3600–43200) | `number` | `3600` | no |
| mfa_age | Max age of valid MFA (in seconds) | `number` | `86400` | no |
| number_of_custom_role_policy_arns | Number of IAM policies to attach to IAM role | `number` | `null` | no |
| poweruser_role_policy_arn | Policy ARN to use for poweruser role | `string` | `"arn:aws:iam::aws:policy/PowerUserAccess"` | no |
| readonly_role_policy_arn | Policy ARN to use for readonly role | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| role_description | IAM Role description | `string` | `""` | no |
| role_name | IAM role name | `string` | `null` | no |
| role_name_prefix | IAM role name prefix | `string` | `null` | no |
| role_path | Path of IAM role | `string` | `"/"` | no |
| role_permissions_boundary_arn | Permissions boundary ARN to use for IAM role | `string` | `""` | no |
| role_requires_mfa | Whether role requires MFA | `bool` | `true` | no |
| role_requires_session_name | Whether role_session_name is required when assuming the role | `bool` | `false` | no |
| role_session_name | Session name for role assumption (usually the username) | `list(string)` | `["${aws:username}"]` | no |
| role_sts_externalid | STS ExternalId condition values (used when MFA is not required) | `any` | `[]` | no |
| tags | A map of tags to add to IAM role resources | `map(string)` | `{}` | no |
| trust_policy_conditions | Condition constraints for trust policy | `list(object)` | `[]` | no |
| trusted_role_actions | Additional trusted role actions | `list(string)` | `["sts:AssumeRole", "sts:TagSession"]` | no |
| trusted_role_arns | ARNs of AWS entities who can assume these roles | `list(string)` | `[]` | no |
| trusted_role_services | AWS services that can assume these roles | `list(string)` | `[]` | no |

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