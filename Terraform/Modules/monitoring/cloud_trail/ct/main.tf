resource "aws_cloudtrail" "this" {
  count = var.create ? 1 : 0

  name                          = var.name
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation
  enable_logging                = var.enable_logging
  is_organization_trail         = var.is_organization_trail
  kms_key_id                    = var.kms_key_id

  cloud_watch_logs_role_arn  = var.enable_cloudwatch_logs ? var.cloudwatch_logs_role_arn : null
  cloud_watch_logs_group_arn = var.enable_cloudwatch_logs ? "${var.cloudwatch_logs_group_arn}:*" : null

  tags = merge(var.tags, {
    Name = replace(var.name, ".", "-")
  })
}