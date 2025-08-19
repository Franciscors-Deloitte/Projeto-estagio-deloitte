## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_iam_user.this | resource |
| aws_iam_user_login_profile.this | resource |
| aws_iam_access_key.this | resource |
| aws_iam_user_policy.inline | resource |
| aws_iam_user_policy_attachment.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create an IAM user | `bool` | `true` | no |
| name | Desired name for the IAM user | `string` | `n/a` | yes |
| path | Path in which to create the user | `string` | `"/"` | no |
| tags | A map of tags to add to the user | `map(string)` | `{}` | no |
| force_destroy | When destroying, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices | `bool` | `false` | no |
| permissions_boundary | The ARN of the policy that is used to set the permissions boundary for the user | `string` | `null` | no |
| policy_arns | List of IAM policy ARNs to attach to the user | `list(string)` | `[]` | no |
| inline_policies | Map of inline policy documents to attach to the user | `map(string)` | `{}` | no |
| create_iam_access_key | Whether to create an IAM access key for the user | `bool` | `false` | no |
| pgp_key | PGP key to encrypt the generated secret. (Can be a base-64 encoded public key, Keybase username, or PGP key fingerprint) | `string` | `null` | no |
| password_reset_required | Whether the user should be forced to reset the password on first login | `bool` | `true` | no |
| password_length | Password length for the login profile | `number` | `20` | no |
| create_iam_user_login_profile | Whether to create an IAM user login profile (console password) | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam_user_name | The user's name |
| iam_user_arn | The ARN assigned by AWS for this user |
| iam_user_unique_id | The unique ID assigned by AWS |
| iam_user_login_profile_password | The user password |
| policy_arns | The list of ARNs of policies directly assigned to the IAM user |