##################################
# Web ACL
##################################
resource "aws_wafv2_web_acl" "this" {
  count       = var.create ? 1 : 0
  name        = var.name
  description = var.description
  scope       = var.scope

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = replace(var.name, ".", "-")
    sampled_requests_enabled   = true
  }

  rule {
    name     = "block_bad_user_agents"
    priority = 1

    action {
      block {}
    }

    statement {
      byte_match_statement {
        search_string         = "BadBot"
        positional_constraint = "CONTAINS"

        field_to_match {
          single_header {
            name = "user-agent"
          }
        }

        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block_bad_user_agents"
      sampled_requests_enabled   = true
    }
  }

  tags = merge(var.tags, {
    Name = replace(var.name, ".", "-")
  })
}

##################################
# Web ACL Association
##################################
resource "aws_wafv2_web_acl_association" "this" {
  count = var.associate_with_resource ? 1 : 0

  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this[0].arn
}