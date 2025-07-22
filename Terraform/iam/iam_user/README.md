## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_iam_openid_connect_provider.this | resource |
| aws_iam_policy_document.this | Data Source |
| aws_iam_policy_document.tags | Data Source |
| aws_iam_role.this | resource |
| aws_iam_role_policy.inline | resource |
| aws_iam_role_policy_attachment.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Determines whether resources will be created | `bool` | `true` | no |
| iam_role_path | IAM role path | `string` | `"/"` | no |
| oidc_audiences | List of audiences (service accounts) for OIDC token | `list(string)` | `[]` | no |
| oidc_fully_qualified_subjects | Fully qualified subjects for role trust relationship | `list(string)` | `[]` | no |
| oidc_subjects_with_wildcards | Wildcard subjects for role trust relationship | `list(string)` | `[]` | no |
| oidc_url | The OIDC Identity Provider URL (without https:// prefix) | `string` | `null` | yes |
| policy_arns | List of policy ARNs to attach to the role | `list(string)` | `[]` | no |
| policy_document | IAM policy document in JSON format for inline policy | `string` | `null` | no |
| role_name | Name of the IAM role | `string` | `null` | yes |
| role_name_prefix | Prefix to use for IAM role name | `string` | `""` | no |
| role_permissions_boundary_arn | ARN of the policy used to set the permissions boundary for the role | `string` | `null` | no |
| role_tags | A map of tags to add to the role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam_openid_connect_provider_arn | ARN of the IAM OIDC provider |
| iam_openid_connect_provider_url | URL of the IAM OIDC provider |
| iam_role_arn | ARN of the IAM role |
| iam_role_name | Name of the IAM role |
| iam_role_unique_id | Unique ID of the IAM role |