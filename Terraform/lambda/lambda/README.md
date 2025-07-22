## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_partition.current | Data Source |
| aws_region.current | Data Source |
| aws_caller_identity.current | Data Source |
| aws_lambda_function.this | resource |
| external.archive_prepare | Data Source |
| local_file.archive_plan | resource |
| null_resource.archive | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Lambda function | `bool` | `true` | no |
| function_name | Name of the Lambda function | `string` | `null` | yes |
| lambda_execution_role_arn | ARN of the IAM role assumed by the Lambda function | `string` | `null` | yes |
| handler | Lambda function handler (e.g., index.handler) | `string` | `null` | yes |
| runtime | Runtime of the Lambda function (e.g., python3.11, nodejs18.x) | `string` | `null` | yes |
| memory_size | Amount of memory available to the function in MB | `number` | `128` | no |
| timeout | Function execution timeout in seconds | `number` | `3` | no |
| publish | Whether to publish a new Lambda function version on update | `bool` | `false` | no |
| description | Description of the Lambda function | `string` | `null` | no |
| package_type | Deployment package type: zip or image | `string` | `"zip"` | no |
| local_existing_package | Path to a pre-built local .zip package | `string` | `null` | no |
| store_on_s3 | Whether to upload the Lambda package to S3 | `bool` | `false` | no |
| s3_existing_package | Reference to an existing Lambda package in S3 | `object({` | `null` | yes |
| s3_bucket | S3 bucket name to store the Lambda package | `string` | `null` | no |
| s3_prefix | S3 key prefix to store the Lambda package | `string` | `null` | no |
| environment_variables | Map of environment variables for the Lambda function | `map(string)` | `{` | no |
| tags | Tags to apply to the Lambda function | `map(string)` | `{` | no |
| create_package | Whether to create the Lambda package locally | `bool` | `true` | no |
| source_path | Path to the source code directory of the Lambda function | `string` | `null` | no |
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
| lambda_function_arn | The ARN of the Lambda Function |
| lambda_function_invoke_arn | The Invoke ARN of the Lambda Function |
| lambda_function_name | The name of the Lambda Function |
| lambda_function_qualified_arn | The ARN identifying your Lambda Function Version |
| lambda_function_qualified_invoke_arn | The Invoke ARN identifying your Lambda Function Version |
| lambda_function_version | Latest published version of Lambda Function |
| lambda_function_last_modified | The date Lambda Function resource was last modified |
| lambda_function_kms_key_arn | The ARN for the KMS encryption key of Lambda Function |
| lambda_function_source_code_hash | Base64-encoded representation of raw SHA-256 sum of the zip file |
| lambda_function_source_code_size | The size in bytes of the function .zip file |
| lambda_function_signing_job_arn | ARN of the signing job |
| lambda_function_signing_profile_version_arn | ARN of the signing profile version |
| lambda_function_url | The URL of the Lambda Function URL |
| lambda_function_url_id | The Lambda Function URL generated id |
| lambda_layer_arn | The ARN of the Lambda Layer with version |
| lambda_layer_layer_arn | The ARN of the Lambda Layer without version |
| lambda_layer_created_date | The date Lambda Layer resource was created |
| lambda_layer_source_code_size | The size in bytes of the Lambda Layer .zip file |
| lambda_layer_version | The Lambda Layer version |
| lambda_event_source_mapping_arn | The event source mapping ARN |
| lambda_event_source_mapping_function_arn | The ARN of the Lambda function the event source mapping is sending events to |
| lambda_event_source_mapping_state | The state of the event source mapping |
| lambda_event_source_mapping_state_transition_reason | The reason the event source mapping is in its current state |
| lambda_event_source_mapping_uuid | The UUID of the created event source mapping |
| lambda_role_arn | The ARN of the IAM role created for the Lambda Function |
| lambda_role_name | The name of the IAM role created for the Lambda Function |
| lambda_role_unique_id | The unique id of the IAM role created for the Lambda Function |
| lambda_cloudwatch_log_group_arn | The ARN of the Cloudwatch Log Group |
| lambda_cloudwatch_log_group_name | The name of the Cloudwatch Log Group |
| local_filename | The filename of zip archive deployed (if deployment was from local) |
| s3_object | The map with S3 object data of zip archive deployed (if deployment was from S3) |