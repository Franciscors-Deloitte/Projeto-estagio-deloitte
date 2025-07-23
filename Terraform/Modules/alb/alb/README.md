## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_db_instance.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the ALB | `bool` | `true` | no |
| name | Name of the ALB | `string` | `null` | yes |
| tags | A map of tags to apply to resources | `map(string)` | `{` | no |
| internal | Whether the ALB is internal or internet-facing | `bool` | `false` | no |
| load_balancer_type | The type of load balancer to create. Valid values are 'application' or 'network' | `string` | `"application"` | no |
| subnets | List of subnet IDs to attach to the ALB | `list(string)` | `null` | yes |
| security_groups | List of security group IDs to associate with the ALB | `list(string)` | `[]` | no |
| ip_address_type | The type of IP addresses used by the ALB. Valid values: 'ipv4' or 'dualstack' | `string` | `"ipv4"` | no |
| idle_timeout | The time (in seconds) that the connection is allowed to be idle | `number` | `60` | no |
| enable_deletion_protection | If true, deletion of the load balancer will be disabled | `bool` | `false` | no |
| access_logs | Configuration for access logs: bucket, prefix, and enabled | `object({` | `null` | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the ALB |
| arn | The ARN of the ALB |
| arn_suffix | ARN suffix of the ALB (useful for CloudWatch) |
| dns_name | The DNS name of the ALB |
| zone_id | The zone ID of the ALB (for DNS integrations) |