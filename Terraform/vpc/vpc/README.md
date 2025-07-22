## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_vpc.this | resource |
| aws_subnet.public | resource |
| aws_subnet.private | resource |
| aws_internet_gateway.this | resource |
| aws_route_table.public | resource |
| aws_route_table_association.public | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the VPC resources | `bool` | `true` | no |
| name | Name of the VPC | `string` | `null` | yes |
| use_name_prefix | Whether to use the name as prefix | `bool` | `false` | no |
| tags | Tags to apply to all resources | `map(string)` | `{` | no |
| cidr | CIDR block for the VPC | `string` | `null` | yes |
| enable_dns_support | Enable DNS support in the VPC | `bool` | `true` | no |
| enable_dns_hostnames | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| instance_tenancy | Tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| availability_zones | List of availability zones to use | `list(string)` | `null` | yes |
| public_subnets | List of public subnet CIDR blocks | `list(string)` | `[]` | no |
| private_subnets | List of private subnet CIDR blocks | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| vpc_arn | ARN of the VPC |
| public_subnet_ids | IDs of the public subnets |
| private_subnet_ids | IDs of the private subnets |
| public_route_table_id | ID of the public route table |
| internet_gateway_id | ID of the Internet Gateway |