## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_wafv2_web_acl.this | resource |
| aws_wafv2_web_acl_association.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the WAFv2 Web ACL | `bool` | `true` | no |
| name | Name of the WAFv2 Web ACL | `string` | `null` | yes |
| description | Description of the Web ACL | `string` | `null` | no |
| scope | Specifies whether this is for CloudFront (CLOUDFRONT) or regional (REGIONAL) resources | `string` | `"REGIONAL"` | no |
| tags | A map of tags to assign to the resources | `map(string)` | `{` | no |
| associate_with_resource | Whether to associate the Web ACL with a resource (ALB, CloudFront, etc.) | `bool` | `false` | no |
| resource_arn | The ARN of the resource to associate with the Web ACL | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| web_acl_id | ID of the WAFv2 Web ACL |
| web_acl_arn | ARN of the WAFv2 Web ACL |
| web_acl_name | Name of the WAFv2 Web ACL |