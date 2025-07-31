##################################
# General settings
##################################

variable "create" {
  description = "Whether to create the managed node group"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the node group"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels to apply"
  type        = map(string)
  default     = {}
}

##################################
# Network and identity
##################################

variable "subnet_ids" {
  description = "Subnets for node group"
  type        = list(string)
}

variable "node_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
}

##################################
# Scaling and compute
##################################

variable "instance_types" {
  description = "Instance types for the nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "disk_size" {
  description = "Disk size in GiB"
  type        = number
  default     = 20
}

variable "capacity_type" {
  description = "Capacity type (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
}

##################################
# Updates and versioning
##################################

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = null
}

variable "release_version" {
  description = "AMI release version"
  type        = string
  default     = null
}

variable "ami_type" {
  description = "AMI type for the node group"
  type        = string
  default     = null
}

variable "max_unavailable" {
  description = "Max unavailable nodes during update"
  type        = number
  default     = 1
}