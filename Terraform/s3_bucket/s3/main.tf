##################################
# Locals
##################################
locals {
  bucket_name = var.use_name_prefix ? "${var.name}-" : var.name

  grants               = try(jsondecode(var.grant), var.grant)
  cors_rules           = try(jsondecode(var.cors_rule), var.cors_rule)
  lifecycle_rules      = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)
  intelligent_tiering  = try(jsondecode(var.intelligent_tiering), var.intelligent_tiering)
  metric_configuration = try(jsondecode(var.metric_configuration), var.metric_configuration)
}

##################################
# S3 Bucket
##################################
resource "aws_s3_bucket" "this" {
  count         = var.create ? 1 : 0
  bucket        = var.use_name_prefix ? null : var.name
  bucket_prefix = var.use_name_prefix ? local.bucket_name : null
  force_destroy = var.force_destroy
  tags          = merge(var.tags, { Name = replace(var.name, ".", "-") })
}

##################################
# ACL
##################################
resource "aws_s3_bucket_acl" "this" {
  count  = var.enable_acl ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  acl    = var.acl
}

##################################
# Versioning
##################################
resource "aws_s3_bucket_versioning" "this" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

##################################
# Logging
##################################
resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}

##################################
# Bucket Policy
##################################
resource "aws_s3_bucket_policy" "this" {
  count  = var.attach_policy ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  policy = var.policy
}

##################################
# Ownership Controls
##################################
resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.enable_ownership_controls ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  rule {
    object_ownership = var.object_ownership
  }
}

##################################
# Public Access Block
##################################
resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.block_public_acls ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

##################################
# Lifecycle Rules
##################################
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_lifecycle ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  rule = local.lifecycle_rules
}

##################################
# CORS
##################################
resource "aws_s3_bucket_cors_configuration" "this" {
  count  = var.enable_cors ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  cors_rule = local.cors_rules
}

##################################
# Metrics
##################################
resource "aws_s3_bucket_metric" "this" {
  count  = var.enable_metrics ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  name = local.metric_configuration.name
  filter {
    prefix = try(local.metric_configuration.prefix, null)
    tags   = try(local.metric_configuration.tags, null)
  }
}

##################################
# Intelligent Tiering
##################################
resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  count  = var.enable_intelligent_tiering ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  name   = local.intelligent_tiering.name
  status = local.intelligent_tiering.status

  tiering {
    access_tier = local.intelligent_tiering.access_tier
    days        = local.intelligent_tiering.days
  }
}