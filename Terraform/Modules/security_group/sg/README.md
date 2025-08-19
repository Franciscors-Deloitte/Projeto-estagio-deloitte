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
| create | Whether to create any resources | `bool` | `true` | no |
| create_sg | Whether to create security group | `bool` | `true` | no |
| vpc_id | VPC ID to create the security group in | `string` | `n/a` | yes |
| name | Security group name | `string` | `n/a` | yes |
| use_name_prefix | Whether to use `name` as a prefix | `bool` | `false` | no |
| description | Security group description | `string` | `"Managed by Terraform"` | no |
| revoke_rules_on_delete | Instruct Terraform to revoke all rules on delete. Enable for EMR. | `bool` | `false` | no |
| tags | A mapping of tags to assign to security group | `map(string)` | `{}` | no |
| ingress_rules | List of ingress rules to create | `list(object({ protocol = string, from_port = number, to_port = number, cidr_blocks = list(string), ipv6_cidr_blocks = list(string), prefix_list_ids = list(string), security_groups = list(string), self = bool, description = string }))` | `n/a` | yes |
| egress_rules | List of egress rules to create | `list(object({ protocol = string, from_port = number, to_port = number, cidr_blocks = list(string), ipv6_cidr_blocks = list(string), prefix_list_ids = list(string), security_groups = list(string), self = bool, description = string }))` | `n/a` | yes |

## Outputs

| Name | Description |
|------|-------------|
| security_group_arn | The ARN of the security group |
| security_group_id | The ID of the security group |
| security_group_vpc_id | The VPC ID |
| security_group_owner_id | The owner ID |
| security_group_name | The name of the security group |
| security_group_description | The description of the security group |