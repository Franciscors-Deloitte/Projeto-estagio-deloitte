output "lambda_function_arn" {
  value = try(aws_lambda_function.this[0].arn, "")
}

output "lambda_function_invoke_arn" {
  value = try(aws_lambda_function.this[0].invoke_arn, "")
}

output "lambda_function_name" {
  value = try(aws_lambda_function.this[0].function_name, "")
}

output "lambda_function_qualified_arn" {
  value = try(aws_lambda_function.this[0].qualified_arn, "")
}

output "lambda_function_qualified_invoke_arn" {
  value = try(aws_lambda_function.this[0].qualified_invoke_arn, "")
}

output "lambda_function_version" {
  value = try(aws_lambda_function.this[0].version, "")
}

output "lambda_function_last_modified" {
  value = try(aws_lambda_function.this[0].last_modified, "")
}

output "lambda_function_kms_key_arn" {
  value = try(aws_lambda_function.this[0].kms_key_arn, "")
}

output "lambda_function_source_code_hash" {
  value = try(aws_lambda_function.this[0].source_code_hash, "")
}

output "lambda_function_source_code_size" {
  value = try(aws_lambda_function.this[0].source_code_size, "")
}

output "lambda_function_signing_job_arn" {
  value = try(aws_lambda_function.this[0].signing_job_arn, "")
}

output "lambda_function_signing_profile_version_arn" {
  value = try(aws_lambda_function.this[0].signing_profile_version_arn, "")
}

output "lambda_function_url" {
  description = "Lambda Function URL (if created)"
  value       = var.create_function_url ? try(aws_lambda_function_url.this[0].function_url, null) : null
}