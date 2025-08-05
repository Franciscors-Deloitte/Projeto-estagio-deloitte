data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  create = var.create

  archive_filename        = try(data.external.archive_prepare[0].result.filename, null)
  archive_filename_string = local.archive_filename != null ? local.archive_filename : ""
  archive_was_missing     = try(data.external.archive_prepare[0].result.was_missing, false)

  filename    = var.local_existing_package != null ? var.local_existing_package : (var.store_on_s3 ? null : local.archive_filename)
  was_missing = var.local_existing_package != null ? !fileexists(var.local_existing_package) : local.archive_was_missing

  s3_bucket = var.s3_existing_package != null ? try(var.s3_existing_package.bucket, null) : (var.store_on_s3 ? var.s3_bucket : null)

  s3_key = var.s3_existing_package != null ? try(var.s3_existing_package.key, null) : (var.store_on_s3 && var.s3_prefix != null ? 
  format("%s%s", var.s3_prefix, basename(local.archive_filename)) : (var.store_on_s3 ? basename(local.archive_filename) : null))

  s3_object_version = var.s3_existing_package != null ? try(var.s3_existing_package.version_id, null) : (var.store_on_s3 ? try(aws_s3_object.lambda_package[0].version_id, null) : null)
}

resource "aws_lambda_function" "this" {
  count = local.create ? 1 : 0

  function_name = var.function_name
  role          = var.lambda_execution_role_arn
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout
  publish       = var.publish
  description   = var.description
  package_type  = var.package_type

  filename         = local.filename
  s3_bucket        = local.s3_bucket
  s3_key           = local.s3_key
  s3_object_version = local.s3_object_version

  source_code_hash = try(filebase64sha256(local.filename), null)

  environment {
    variables = var.environment_variables
  }

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }

  tags = merge(var.tags, {
    Name = replace(var.function_name, ".", "-")
  })
}

##################################
# Lambda permission for S3 invoke
##################################

resource "aws_lambda_permission" "allow_s3" {
  count         = var.allow_s3_invocation ? 1 : 0

  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[0].function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}

##################################
# Lambda Function URL 
##################################

resource "aws_lambda_function_url" "this" {
  count              = var.create_function_url ? 1 : 0
  function_name      = aws_lambda_function.this[0].function_name
  authorization_type = "NONE"
}