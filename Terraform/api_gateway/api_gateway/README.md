## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_apigatewayv2_api.this | resource |
| aws_apigatewayv2_stage.this | resource |
| aws_apigatewayv2_route.this | resource |
| aws_apigatewayv2_integration.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the API Gateway | `bool` | `true` | no |
| name | Name of the API Gateway | `string` | `null` | yes |
| description | Description of the API Gateway | `string` | `""` | no |
| protocol_type | Type of API Gateway protocol. Valid values: HTTP or WEBSOCKET | `string` | `"HTTP"` | no |
| tags | Tags to apply to all resources | `map(string)` | `{` | no |
| cors_configuration | CORS configuration for the API | `object({` | `null` | yes |
| stage_name | Name of the deployment stage (e.g., prod, dev) | `string` | `"prod"` | no |
| auto_deploy | Whether to auto-deploy the API when changes are made | `bool` | `true` | no |
| access_log_destination_arn | ARN of the CloudWatch Logs group for access logging | `string` | `null` | no |
| access_log_format | Format for API access logs | `string` | `null` | no |
| logging_level | Logging level for the stage. Valid values: INFO, ERROR, OFF | `string` | `"INFO"` | no |
| throttling_burst_limit | Throttling burst limit for the default route | `number` | `null` | no |
| throttling_rate_limit | Throttling rate limit (requests per second) for the default route | `number` | `null` | no |
| create_routes_and_integrations | Whether to create API routes and integrations | `bool` | `true` | no |
| routes | List of routes and integration configuration | `list(object({` | `null` | yes |
| body | OpenAPI specification body to import (for HTTP APIs only) | `string` | `null` | no |
| api_key_selection_expression | The API key selection expression for WebSocket APIs | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| api_id | The API identifier |
| api_endpoint | URI of the API |
| api_arn | The ARN of the API |
| integrations | Map of the integrations created and their attributes |
| routes | Map of the routes created and their attributes |
| stage_id | The stage identifier |
| stage_arn | The stage ARN |
| stage_invoke_url | The URL to invoke the API pointing to the stage |