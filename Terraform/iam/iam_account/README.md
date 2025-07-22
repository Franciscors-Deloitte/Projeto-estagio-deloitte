## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_caller_identity.this | Data Source |
| aws_iam_account_alias.this | resource |
| aws_iam_account_password_policy.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| get_caller_identity | Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized | `bool` | `true` | no |
| account_alias | AWS IAM account alias for this account | `string` | `null` | yes |
| create_account_password_policy | Whether to create AWS IAM account password policy | `bool` | `true` | no |
| max_password_age | The number of days that an user password is valid. | `number` | `0` | no |
| minimum_password_length | Minimum length to require for user passwords | `number` | `8` | no |
| allow_users_to_change_password | Whether to allow users to change their own password | `bool` | `true` | no |
| hard_expiry | Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) | `bool` | `false` | no |
| password_reuse_prevention | The number of previous passwords that users are prevented from reusing | `number` | `null` | no |
| require_lowercase_characters | Whether to require lowercase characters for user passwords | `bool` | `true` | no |
| require_uppercase_characters | Whether to require uppercase characters for user passwords | `bool` | `true` | no |
| require_numbers | Whether to require numbers for user passwords | `bool` | `true` | no |
| require_symbols | Whether to require symbols for user passwords | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam_account_password_policy_expire_passwords | Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present. |