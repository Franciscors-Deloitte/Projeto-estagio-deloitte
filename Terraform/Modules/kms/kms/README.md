## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_partition.current | Data Source |
| aws_caller_identity.current | Data Source |
| aws_kms_key.this | resource |
| aws_kms_alias.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the KMS key | `bool` | `true` | no |
| name | Name of the KMS key (used in tags) | `string` | `null` | yes |
| tags | Tags to apply to the KMS key | `map(string)` | `{` | no |
| description | The description of the KMS key | `string` | `null` | no |
| deletion_window_in_days | Waiting period before KMS key is deleted after destruction (7–30 days) | `number` | `30` | no |
| enable_key_rotation | Specifies whether key rotation is enabled | `bool` | `true` | no |
| is_enabled | Specifies whether the key is enabled | `bool` | `true` | no |
| customer_master_key_spec | Specifies the type of KMS key to create | `string` | `"SYMMETRIC_DEFAULT"` | no |
| key_usage | Defines what the key is used for: ENCRYPT_DECRYPT or SIGN_VERIFY | `string` | `"ENCRYPT_DECRYPT"` | no |
| multi_region | Indicates whether the key is a multi-Region primary key | `bool` | `false` | no |
| bypass_policy_lockout_safety_check | Specifies whether to bypass the key policy lockout safety check | `bool` | `false` | no |
| policy | Key policy to attach to the KMS key | `string` | `null` | no |
| alias_name | Name of the alias to associate with the KMS key | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| key_arn | ARN of the KMS key |
| key_id | ID of the KMS key |
| key_policy | The IAM resource policy set on the KMS key |
| alias_name | Name of the alias created (if any) |