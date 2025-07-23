##################################
# Locals
##################################
locals {
  is_http      = var.protocol_type == "HTTP"
  is_websocket = var.protocol_type == "WEBSOCKET"
  create_routes_and_integrations = var.create && var.create_routes_and_integrations
}

##################################
# API Gateway
##################################
resource "aws_apigatewayv2_api" "this" {
  count                         = var.create ? 1 : 0
  name                          = var.name
  description                   = var.description
  protocol_type                 = var.protocol_type
  api_key_selection_expression = local.is_websocket ? var.api_key_selection_expression : null
  body                          = local.is_http ? var.body : null

  dynamic "cors_configuration" {
    for_each = local.is_http && var.cors_configuration != null ? [var.cors_configuration] : []
    content {
      allow_credentials = cors_configuration.value.allow_credentials
      allow_headers     = cors_configuration.value.allow_headers
      allow_methods     = cors_configuration.value.allow_methods
      allow_origins     = cors_configuration.value.allow_origins
      expose_headers    = cors_configuration.value.expose_headers
      max_age           = cors_configuration.value.max_age
    }
  }

  tags = merge(var.tags, { Name = replace(var.name, ".", "-") })
}

##################################
# Stage
##################################
resource "aws_apigatewayv2_stage" "this" {
  count         = var.create ? 1 : 0
  name          = var.stage_name
  api_id        = aws_apigatewayv2_api.this[0].id
  auto_deploy   = var.auto_deploy
  tags          = var.tags
  access_log_settings {
    destination_arn = var.access_log_destination_arn
    format          = var.access_log_format
  }
  default_route_settings {
    logging_level = var.logging_level
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit  = var.throttling_rate_limit
  }
}

##################################
# Route
##################################
resource "aws_apigatewayv2_route" "this" {
  for_each = local.create_routes_and_integrations ? { for r in var.routes : r.route_key => r } : {}

  api_id    = aws_apigatewayv2_api.this[0].id
  route_key = each.value.route_key
  target    = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
}

##################################
# Integration
##################################
resource "aws_apigatewayv2_integration" "this" {
  for_each = local.create_routes_and_integrations ? { for r in var.routes : r.route_key => r } : {}

  api_id                 = aws_apigatewayv2_api.this[0].id
  integration_type       = each.value.integration_type
  integration_uri        = each.value.integration_uri
  integration_method     = each.value.integration_method
  payload_format_version = each.value.payload_format_version
  timeout_milliseconds   = try(each.value.timeout_milliseconds, null)
}