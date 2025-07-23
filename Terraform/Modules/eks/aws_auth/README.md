## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| kubernetes_config_map.aws_auth | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the aws-auth ConfigMap | `bool` | `true` | no |
| create_aws_auth_configmap | Control creation of aws-auth ConfigMap | `bool` | `true` | no |
| aws_auth_roles | List of role mappings to add to the aws-auth ConfigMap | `any` | `[]` | no |
| aws_auth_users | List of user mappings to add to the aws-auth ConfigMap | `any` | `[]` | no |
| aws_auth_accounts | List of AWS account IDs to add to the aws-auth ConfigMap | `list(string)` | `[]` | no |
| labels | Labels to add to the aws-auth ConfigMap metadata | `map(string)` | `{` | no |

## Outputs

No Outputs.