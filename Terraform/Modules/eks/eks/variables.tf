########################################
# General variables
########################################

variable "create" {
  description = "Controls if resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

########################################
# Cluster configuration
########################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_ip_family" {
  description = "IP family to use for the cluster"
  type        = string
  default     = ""
}

variable "cluster_service_ipv4_cidr" {
  description = "CIDR block for Kubernetes service IPs"
  type        = string
  default     = ""
}

variable "cluster_endpoint_private_access" {
  description = "Enable private access to the cluster endpoint"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDRs allowed to access the public endpoint"
  type        = list(string)
  default     = []
}

variable "cluster_enabled_log_types" {
  description = "List of cluster control plane log types to enable"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnet IDs for worker nodes"
  type        = list(string)
  default     = []
}

variable "cluster_additional_security_group_ids" {
  description = "Additional security groups to associate with the cluster"
  type        = list(string)
  default     = []
}

variable "cluster_encryption_config" {
  description = "Encryption config for the cluster"
  type        = any
  default     = {}
}

variable "encryption_resources" {
  description = "Resources to encrypt with the provided KMS key"
  type        = list(string)
  default     = []
}

variable "kms_key_arn" {
  description = "KMS Key ARN to use for encryption"
  type        = string
  default     = ""
}

variable "iam_role_arn" {
  description = "IAM role ARN to use for the EKS cluster"
  type        = string
  default     = ""
}

variable "outpost_config" {
  description = "Configuration for AWS Outpost clusters"
  type        = any
  default     = {}
}

variable "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster"
  type        = string
  default     = ""
}

variable "clusters" {
  description = "Map of EKS clusters to create"
  type = map(object({
    cluster_name                          = string
    cluster_version                       = string
    cluster_ip_family                     = string
    cluster_service_ipv4_cidr            = string
    subnet_ids                            = list(string)
    cluster_security_group_id             = string
    cluster_additional_security_group_ids = list(string)
    cluster_endpoint_private_access       = bool
    cluster_endpoint_public_access        = bool
    cluster_endpoint_public_access_cidrs  = list(string)
    cluster_enabled_log_types             = list(string)
    kms_key_arn                           = string
    encryption_resources                  = list(string)
    cluster_encryption_config             = map(any)
    iam_role_arn                          = string
    tags                                  = map(string)
  }))
}

########################################
# Node groups configuration
########################################

variable "create_cni_ipv6_iam_policy" {
  description = "Whether to create the CNI IPv6 IAM policy"
  type        = bool
  default     = false
}

variable "dataplane_wait_duration" {
  description = "Duration to wait for dataplane to be ready"
  type        = string
  default     = ""
}