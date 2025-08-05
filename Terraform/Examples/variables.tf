variable "eks_cluster_name" {
  description = "Name of the EKS cluster instance to be used for node groups and other dependent resources"
  type        = string
  default     = "cluster-1" # Optional: default cluster name to use if multiple clusters are defined

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.eks_cluster_name))
    error_message = "Cluster name must contain only letters, numbers, hyphens, or underscores."
  }
}