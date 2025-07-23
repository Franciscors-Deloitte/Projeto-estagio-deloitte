## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_security_group.this | resource |
| aws_security_group_rule.ingress | resource |
| aws_security_group_rule.egress | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create security group and all rules | `bool` | `true` | no |
| create_sg | Whether to create security group | `bool` | `true` | no |
| vpc_id | ID of the VPC where to create security group | `string` | `null` | no |
| name | Name of security group - not required if create_sg is false | `string` | `null` | no |
| use_name_prefix | Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation | `bool` | `true` | no |
| description | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| revoke_rules_on_delete | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR. | `bool` | `false` | no |
| tags | A mapping of tags to assign to security group | `map(string)` | `{` | no |
| ingress_rules | List of ingress rules to create by name | `list(map(string))` | `[]` | no |
| egress_rules | List of egress rules to create by name | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| security_group_arn | The ARN of the security group |
| security_group_id | The ID of the security group |
| security_group_vpc_id | The VPC ID |
| security_group_owner_id | The owner ID |
| security_group_name | The name of the security group |
| security_group_description | The description of the security group |