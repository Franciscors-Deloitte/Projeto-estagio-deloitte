variable "create" {
  description = "Controls whether to create the Lambda function"
  type        = bool
  default     = true
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_execution_role_arn" {
  description = "ARN of the IAM role assumed by the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda function handler (e.g., index.handler)"
  type        = string
}

variable "runtime" {
  description = "Runtime of the Lambda function (e.g., python3.11, nodejs18.x)"
  type        = string
}

variable "memory_size" {
  description = "Amount of memory available to the function in MB"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Function execution timeout in seconds"
  type        = number
  default     = 3
}

variable "publish" {
  description = "Whether to publish a new Lambda function version on update"
  type        = bool
  default     = false
}

variable "description" {
  description = "Description of the Lambda function"
  type        = string
  default     = null
}

variable "package_type" {
  description = "Deployment package type: zip or image"
  type        = string
  default     = "zip"
}

variable "local_existing_package" {
  description = "Path to a pre-built local .zip package"
  type        = string
  default     = null
}

variable "store_on_s3" {
  description = "Whether to upload the Lambda package to S3"
  type        = bool
  default     = false
}

variable "s3_existing_package" {
  description = "Reference to an existing Lambda package in S3"
  type = object({
    bucket     = string
    key        = string
    version_id = optional(string)
  })
  default = null
}

variable "s3_bucket" {
  description = "S3 bucket name to store the Lambda package"
  type        = string
  default     = null
}

variable "s3_prefix" {
  description = "S3 key prefix to store the Lambda package"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Map of environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default     = {}
}

##################################
# Package
##################################

variable "create_package" {
  description = "Whether to create the Lambda package locally"
  type        = bool
  default     = true
}

variable "source_path" {
  description = "Path to the source code directory of the Lambda function"
  type        = string
  default     = null
}

variable "artifacts_dir" {
  description = "Local directory where packaged artifacts are stored"
  type        = string
  default     = ".terraform-lambda-artifacts"
}

variable "build_in_docker" {
  description = "Whether to use Docker to build the Lambda package"
  type        = bool
  default     = false
}

variable "docker_file" {
  description = "Path to a custom Dockerfile"
  type        = string
  default     = null
}

variable "docker_image" {
  description = "Docker image to use for Lambda packaging"
  type        = string
  default     = "lambci/lambda:build-python3.11"
}

variable "docker_build_root" {
  description = "Root directory mounted in the Docker container during build"
  type        = string
  default     = null
}

variable "docker_entrypoint" {
  description = "Custom entrypoint command for Docker container"
  type        = list(string)
  default     = []
}

variable "docker_additional_options" {
  description = "Additional options to pass to Docker run command"
  type        = list(string)
  default     = []
}

variable "docker_pip_cache" {
  description = "Enable pip dependency caching inside Docker container"
  type        = bool
  default     = false
}

variable "docker_with_ssh_agent" {
  description = "Enable SSH agent forwarding in Docker container"
  type        = bool
  default     = false
}

variable "quiet_archive_local_exec" {
  description = "Suppress output during local archive creation"
  type        = bool
  default     = false
}

variable "recreate_missing_package" {
  description = "Recreate the package if the file is missing"
  type        = bool
  default     = false
}

variable "trigger_on_package_timestamp" {
  description = "Optional string to force rebuild based on a timestamp"
  type        = string
  default     = null
}

variable "hash_extra" {
  description = "Extra string to influence the content hash of the package"
  type        = string
  default     = ""
}