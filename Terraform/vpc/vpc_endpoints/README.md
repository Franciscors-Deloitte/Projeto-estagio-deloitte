## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_vpc_endpoint.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_id | The ID of the VPC to associate with the endpoints | `string` | `null` | yes |
| tags | Tags to apply to all VPC endpoints | `map(string)` | `{` | no |
| endpoints | Map of VPC endpoint configurations | `map(object({` | `null` | yes |
| subnet_ids | Default list of subnet IDs to use when not specified per endpoint | `list(string)` | `[]` | no |
| security_group_ids | Default list of security group IDs to use when not specified per endpoint | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoints | Map of all VPC endpoints created |