## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_partition.current | Data Source |
| aws_caller_identity.current | Data Source |
| aws_iam_session_context.current | Data Source |
| aws_iam_role.this | resource |
| aws_eks_cluster.this | resource |
| time_sleep.this | resource |
| aws_iam_policy_document.cni_ipv6_policy | Data Source |
| aws_iam_policy.cni_ipv6_policy | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls if resources should be created | `bool` | `true` | no |
| putin_khuylo | Just a funny/irrelevant flag | `bool` | `false` | no |
| tags | Tags to apply to all resources | `map(string)` | `{` | no |
| cluster_name | Name of the EKS cluster | `string` | `""` | no |
| cluster_version | Kubernetes version for the EKS cluster | `string` | `""` | no |
| cluster_ip_family | IP family to use for the cluster | `string` | `""` | no |
| cluster_service_ipv4_cidr | CIDR block for Kubernetes service IPs | `string` | `""` | no |
| cluster_endpoint_private_access | Enable private access to the cluster endpoint | `bool` | `false` | no |
| cluster_endpoint_public_access | Enable public access to the cluster endpoint | `bool` | `true` | no |
| cluster_endpoint_public_access_cidrs | CIDRs allowed to access the public endpoint | `list(string)` | `[]` | no |
| cluster_enabled_log_types | List of cluster control plane log types to enable | `list(string)` | `[]` | no |
| subnet_ids | Subnet IDs for worker nodes | `list(string)` | `[]` | no |
| cluster_additional_security_group_ids | Additional security groups to associate with the cluster | `list(string)` | `[]` | no |
| cluster_encryption_config | Encryption config for the cluster | `any` | `{` | no |
| encryption_resources | Resources to encrypt with the provided KMS key | `list(string)` | `[]` | no |
| kms_key_arn | KMS Key ARN to use for encryption | `string` | `""` | no |
| iam_role_arn | IAM role ARN to use for the EKS cluster | `string` | `""` | no |
| outpost_config | Configuration for AWS Outpost clusters | `any` | `{` | no |
| cluster_security_group_id | The security group ID of the EKS cluster | `string` | `""` | no |
| create_cni_ipv6_iam_policy | Whether to create the CNI IPv6 IAM policy | `bool` | `false` | no |
| dataplane_wait_duration | Duration to wait for dataplane to be ready | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_arn | The Amazon Resource Name (ARN) of the cluster |
| cluster_certificate_authority_data | Base64 encoded certificate data required to communicate with the cluster |
| cluster_endpoint | Endpoint for your Kubernetes API server |
| cluster_id | The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts |
| cluster_name | The name of the EKS cluster |
| cluster_version | The Kubernetes version for the cluster |
| cluster_platform_version | Platform version for the cluster |
| cluster_status | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| cluster_oidc_issuer_url | The URL on the EKS cluster for the OpenID Connect identity provider |
| oidc_provider | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| cluster_primary_security_group_id | Cluster security group used for control-plane-to-data-plane communication |
| cluster_service_cidr | The CIDR block for service IPs in the cluster |
| cluster_ip_family | The IP family used by the cluster |
| cluster_iam_role_name | Cluster IAM role name |
| cluster_iam_role_arn | Cluster IAM role ARN |
| cluster_iam_role_unique_id | Stable and unique string identifying the IAM role |