## Modules

No Modules.

## Resources

| Name | Type | Defined In |
|------|------|------------|
| aws_lambda_function.this | resource | main.tf |
| aws_lambda_permission.allow_s3 | resource | main.tf |
| aws_lambda_function_url.this | resource | main.tf |
| local_file.archive_plan | resource | package.tf |
| null_resource.archive | resource | package.tf |
| aws_s3_object.lambda_package | resource | package.tf |
| aws_partition.current | Data Source | main.tf |
| aws_region.current | Data Source | main.tf |
| aws_caller_identity.current | Data Source | main.tf |
| external.archive_prepare | Data Source | package.tf |
| archive_file.lambda | Data Source | package.tf |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Lambda function | `bool` | `true` | no |
| function_name | Name of the Lambda function | `string` | `null` | **yes** |
| lambda_execution_role_arn | ARN of the IAM role assumed by the Lambda function | `string` | `null` | **yes** |
| handler | Lambda function handler (e.g., index.handler) | `string` | `null` | **yes** |
| runtime | Runtime of the Lambda function (e.g., python3.11, nodejs18.x) | `string` | `null` | **yes** |
| memory_size | Amount of memory available to the function in MB | `number` | `128` | no |
| timeout | Function execution timeout in seconds | `number` | `3` | no |
| publish | Whether to publish a new Lambda function version on update | `bool` | `false` | no |
| description | Description of the Lambda function | `string` | `null` | no |
| package_type | Deployment package type: zip or image | `string` | `"zip"` | no |
| local_existing_package | Path to a pre-built local .zip package | `string` | `null` | no |
| store_on_s3 | Whether to upload the Lambda package to S3 | `bool` | `false` | no |
| s3_existing_package | Reference to an existing Lambda package in S3 | `object({ bucket = string, key = string, version_id = optional(string) })` | `null` | no |
| s3_bucket | S3 bucket name to store the Lambda package | `string` | `null` | no |
| s3_prefix | S3 key prefix to store the Lambda package | `string` | `null` | no |
| s3_key | S3 object key (full path) for the Lambda package | `string` | `null` | no |
| environment_variables | Map of environment variables for the Lambda function | `map(string)` | `{}` | no |
| tags | Tags to apply to the Lambda function | `map(string)` | `{}` | no |
| vpc_subnet_ids | List of VPC subnet IDs for the Lambda function | `list(string)` | `null` | no |
| vpc_security_group_ids | List of VPC security group IDs for the Lambda function | `list(string)` | `null` | no |
| allow_s3_invocation | Whether to allow S3 to invoke the Lambda function | `bool` | `false` | no |
| s3_bucket_arn | ARN of the S3 bucket allowed to invoke the Lambda function | `string` | `null` | no |
| create_function_url | Whether to create a Lambda Function URL for public access | `bool` | `false` | no |
| create_package | Whether to create the Lambda package locally | `bool` | `true` | no |
| source_path | Path to the source code directory of the Lambda function | `string` | `null` | no |
| output_path | Path to store the generated zip file from archive_file | `string` | `null` | no |
| artifacts_dir | Local directory where packaged artifacts are stored | `string` | `".terraform-lambda-artifacts"` | no |
| build_in_docker | Whether to use Docker to build the Lambda package | `bool` | `false` | no |
| docker_file | Path to a custom Dockerfile | `string` | `null` | no |
| docker_image | Docker image to use for Lambda packaging | `string` | `"lambci/lambda:build-python3.11"` | no |
| docker_build_root | Root directory mounted in the Docker container during build | `string` | `null` | no |
| docker_entrypoint | Custom entrypoint command for Docker container | `list(string)` | `[]` | no |
| docker_additional_options | Additional options to pass to Docker run command | `list(string)` | `[]` | no |
| docker_pip_cache | Enable pip dependency caching inside Docker container | `bool` | `false` | no |
| docker_with_ssh_agent | Enable SSH agent forwarding in Docker container | `bool` | `false` | no |
| quiet_archive_local_exec | Suppress output during local archive creation | `bool` | `false` | no |
| recreate_missing_package | Recreate the package if the file is missing | `bool` | `false` | no |
| trigger_on_package_timestamp | Optional string to force rebuild based on a timestamp | `string` | `null` | no |
| hash_extra | Extra string to influence the content hash of the package | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_function_arn |  |
| lambda_function_invoke_arn |  |
| lambda_function_name |  |
| lambda_function_qualified_arn |  |
| lambda_function_qualified_invoke_arn |  |
| lambda_function_version |  |
| lambda_function_last_modified |  |
| lambda_function_kms_key_arn |  |
| lambda_function_source_code_hash |  |
| lambda_function_source_code_size |  |
| lambda_function_signing_job_arn |  |
| lambda_function_signing_profile_version_arn |  |
| lambda_function_url | Lambda Function URL (if created) |