## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_partition.current | Data Source |
| aws_caller_identity.current | Data Source |
| aws_region.current | Data Source |
| aws_iam_policy_document.this | Data Source |
| aws_iam_role_policy_attachment.this | resource |
| aws_iam_policy_document.aws_gateway_controller | Data Source |
| aws_iam_policy.aws_gateway_controller | resource |
| aws_iam_role_policy_attachment.aws_gateway_controller | resource |
| aws_iam_policy_document.cert_manager | Data Source |
| aws_iam_policy.cert_manager | resource |
| aws_iam_role_policy_attachment.cert_manager | resource |
| aws_iam_policy_document.cluster_autoscaler | Data Source |
| aws_iam_policy.cluster_autoscaler | resource |
| aws_iam_role_policy_attachment.cluster_autoscaler | resource |
| aws_iam_policy_document.ebs_csi | Data Source |
| aws_iam_policy.ebs_csi | resource |
| aws_iam_role_policy_attachment.ebs_csi | resource |
| aws_iam_policy_document.efs_csi | Data Source |
| aws_iam_policy.efs_csi | resource |
| aws_iam_role_policy_attachment.efs_csi | resource |
| aws_iam_policy_document.mountpoint_s3_csi | Data Source |
| aws_iam_policy.mountpoint_s3_csi | resource |
| aws_iam_role_policy_attachment.mountpoint_s3_csi | resource |
| aws_iam_policy_document.external_dns | Data Source |
| aws_iam_policy.external_dns | resource |
| aws_iam_role_policy_attachment.external_dns | resource |
| aws_iam_policy_document.external_secrets | Data Source |
| aws_iam_policy.external_secrets | resource |
| aws_iam_role_policy_attachment.external_secrets | resource |
| aws_iam_policy_document.fsx_lustre_csi | Data Source |
| aws_iam_policy.fsx_lustre_csi | resource |
| aws_iam_role_policy_attachment.fsx_lustre_csi | resource |
| aws_iam_policy_document.fsx_openzfs_csi | Data Source |
| aws_iam_policy.fsx_openzfs_csi | resource |
| aws_iam_role_policy_attachment.fsx_openzfs_csi | resource |
| aws_iam_policy_document.karpenter_controller | Data Source |
| aws_iam_policy.karpenter_controller | resource |
| aws_iam_role_policy_attachment.karpenter_controller | resource |
| aws_iam_policy_document.load_balancer_controller | Data Source |
| aws_iam_policy.load_balancer_controller | resource |
| aws_iam_role_policy_attachment.load_balancer_controller | resource |
| aws_iam_policy_document.load_balancer_controller_targetgroup_only | Data Source |
| aws_iam_policy.load_balancer_controller_targetgroup_only | resource |
| aws_iam_role_policy_attachment.load_balancer_controller_targetgroup_only | resource |
| aws_iam_policy_document.appmesh_controller | Data Source |
| aws_iam_policy.appmesh_controller | resource |
| aws_iam_role_policy_attachment.appmesh_controller | resource |
| aws_iam_policy_document.appmesh_envoy_proxy | Data Source |
| aws_iam_policy.appmesh_envoy_proxy | resource |
| aws_iam_role_policy_attachment.appmesh_envoy_proxy | resource |
| aws_iam_policy_document.amazon_managed_service_prometheus | Data Source |
| aws_iam_policy.amazon_managed_service_prometheus | resource |
| aws_iam_role_policy_attachment.amazon_managed_service_prometheus | resource |
| aws_iam_policy_document.node_termination_handler | Data Source |
| aws_iam_policy.node_termination_handler | resource |
| aws_iam_role_policy_attachment.node_termination_handler | resource |
| aws_iam_policy_document.velero | Data Source |
| aws_iam_policy.velero | resource |
| aws_iam_role_policy_attachment.velero | resource |
| aws_iam_policy_document.vpc_cni | Data Source |
| aws_iam_policy.vpc_cni | resource |
| aws_iam_role_policy_attachment.vpc_cni | resource |
| aws_iam_role_policy_attachment.amazon_cloudwatch_observability | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_role | Whether to create a role | `bool` | `true` | no |
| role_name | Name of IAM role | `string` | `null` | no |
| role_path | Path of IAM role | `string` | `"/"` | no |
| role_name_prefix | IAM role name prefix | `string` | `null` | no |
| policy_name_prefix | IAM policy name prefix | `string` | `"AmazonEKS_"` | no |
| role_policy_arns | ARNs of any policies to attach to the IAM role | `map(string)` | `{` | no |
| oidc_providers | Map of OIDC providers where each provider map should contain the `provider_arn` and `namespace_service_accounts` | `any` | `{` | no |
| tags | A map of tags to add the the IAM role | `map(any)` | `{` | no |
| assume_role_condition_test | Name of the IAM condition operator to evaluate when assuming the role | `string` | `"StringEquals"` | no |
| allow_self_assume_role | Determines whether to allow the role to be assume itself | `bool` | `false` | no |
| iam_role_name | Name of the IAM role created via iam-assumable-role module | `string` | `null` | yes |
| attach_aws_gateway_controller_policy | Determines whether to attach the AWS Gateway Controller IAM policy to the role | `bool` | `false` | no |
| attach_cert_manager_policy | Determines whether to attach the Cert Manager IAM policy to the role | `bool` | `false` | no |
| cert_manager_hosted_zone_arns | Route53 hosted zone ARNs to allow Cert manager to manage records | `list(string)` | `["arn:aws:route53:::hostedzone/*"]` | no |
| attach_cluster_autoscaler_policy | Determines whether to attach the Cluster Autoscaler IAM policy to the role | `bool` | `false` | no |
| cluster_autoscaler_cluster_ids | [Deprecated - use cluster_autoscaler_cluster_names] List of cluster names to scope permissions within the Cluster Autoscaler policy | `list(string)` | `[]` | no |
| cluster_autoscaler_cluster_names | List of cluster names to scope permissions within the Cluster Autoscaler policy | `list(string)` | `[]` | no |
| attach_ebs_csi_policy | Determines whether to attach the EBS CSI IAM policy to the role | `bool` | `false` | no |
| ebs_csi_kms_cmk_ids | KMS CMK IDs to allow EBS CSI to manage encrypted volumes | `list(string)` | `[]` | no |
| attach_efs_csi_policy | Determines whether to attach the EFS CSI IAM policy to the role | `bool` | `false` | no |
| attach_mountpoint_s3_csi_policy | Determines whether to attach the Mountpoint S3 CSI IAM policy to the role | `bool` | `false` | no |
| mountpoint_s3_csi_bucket_arns | S3 bucket ARNs to allow Mountpoint S3 CSI to list buckets | `list(string)` | `[]` | no |
| mountpoint_s3_csi_kms_arns | KMS Key ARNs to allow Mountpoint S3 CSI to use `aws:kms` SSE | `list(string)` | `[]` | no |
| mountpoint_s3_csi_path_arns | S3 path ARNs to allow Mountpoint S3 CSI driver to manage items at the provided path(s) | `list(string)` | `[]` | no |
| attach_external_dns_policy | Determines whether to attach the External DNS IAM policy to the role | `bool` | `false` | no |
| external_dns_hosted_zone_arns | Route53 hosted zone ARNs to allow External DNS to manage records | `list(string)` | `["arn:aws:route53:::hostedzone/*"]` | no |
| attach_external_secrets_policy | Determines whether to attach the External Secrets policy to the role | `bool` | `false` | no |
| external_secrets_ssm_parameter_arns | SSM Parameter ARNs that contain secrets for External Secrets | `list(string)` | `["arn:aws:ssm:*:*:parameter/*"]` | no |
| external_secrets_secrets_manager_arns | Secrets Manager ARNs for External Secrets | `list(string)` | `["arn:aws:secretsmanager:*:*:secret:*"]` | no |
| external_secrets_kms_key_arns | KMS Key ARNs used by Secrets Manager with External Secrets | `list(string)` | `["arn:aws:kms:*:*:key/*"]` | no |
| external_secrets_secrets_manager_create_permission | Allow External Secrets to use `secretsmanager:CreateSecret` | `bool` | `false` | no |
| attach_fsx_lustre_csi_policy | Determines whether to attach the FSx Lustre CSI policy to the role | `bool` | `false` | no |
| fsx_lustre_csi_service_role_arns | ARNs to allow FSx Lustre CSI to create/manage roles | `list(string)` | `["arn:aws:iam::*:role/aws-service-role/s3.data-source.lustre.fsx.amazonaws.com/*"]` | no |
| attach_fsx_openzfs_csi_policy | Determines whether to attach the FSx OpenZFS CSI policy to the role | `bool` | `false` | no |
| fsx_openzfs_csi_service_role_arns | ARNs to allow FSx OpenZFS CSI to create/manage roles | `list(string)` | `["arn:aws:iam::*:role/aws-service-role/fsx.amazonaws.com/*"]` | no |
| attach_karpenter_controller_policy | Determines whether to attach the Karpenter Controller policy | `bool` | `false` | no |
| karpenter_controller_cluster_id | [Deprecated - use karpenter_controller_cluster_name] | `string` | `"*"` | no |
| karpenter_controller_cluster_name | The cluster name for Karpenter | `string` | `"*"` | no |
| karpenter_tag_key |  | `any` | `null` | yes |
| karpenter_controller_ssm_parameter_arns | SSM Parameter ARNs for AMI IDs used by Karpenter | `list(string)` | `["arn:aws:ssm:*:*:parameter/aws/service/*"]` | no |
| karpenter_controller_node_iam_role_arns | IAM role ARNs for Karpenter-launched nodes | `list(string)` | `["*"]` | no |
| karpenter_subnet_account_id | Account ID of shared subnets | `string` | `""` | no |
| karpenter_sqs_queue_arn | SQS ARN used by Karpenter for node terminations | `string` | `null` | no |
| enable_karpenter_instance_profile_creation | Allow Karpenter to create IAM instance profile | `bool` | `false` | no |
| attach_load_balancer_controller_policy | Determines whether to attach the LB Controller policy | `bool` | `false` | no |
| attach_load_balancer_controller_targetgroup_binding_only_policy | Attach LB Controller policy for TargetGroupBinding only | `bool` | `false` | no |
| load_balancer_controller_targetgroup_arns | Target Group ARNs for LB Controller | `list(string)` | `["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]` | no |
| attach_appmesh_controller_policy | Determines whether to attach the AppMesh Controller policy | `bool` | `false` | no |
| attach_appmesh_envoy_proxy_policy | Determines whether to attach the AppMesh Envoy proxy policy | `bool` | `false` | no |
| attach_amazon_managed_service_prometheus_policy | Attach AMP IAM policy to the role | `bool` | `false` | no |
| amazon_managed_service_prometheus_workspace_arns | AMP workspace ARNs to read/write metrics | `list(string)` | `["*"]` | no |
| attach_velero_policy | Determines whether to attach the Velero policy | `bool` | `false` | no |
| velero_s3_bucket_arns | S3 bucket ARNs used by Velero | `list(string)` | `["*"]` | no |
| attach_vpc_cni_policy | Determines whether to attach the VPC CNI policy | `bool` | `false` | no |
| vpc_cni_enable_cloudwatch_logs | Enable VPC CNI logging to CloudWatch | `bool` | `false` | no |
| vpc_cni_enable_ipv4 | Enable IPv4 support for VPC CNI | `bool` | `false` | no |
| vpc_cni_enable_ipv6 | Enable IPv6 support for VPC CNI | `bool` | `false` | no |
| attach_node_termination_handler_policy | Attach Node Termination Handler policy | `bool` | `false` | no |
| node_termination_handler_sqs_queue_arns | SQS ARNs for termination events | `list(string)` | `["*"]` | no |
| attach_cloudwatch_observability_policy | Attach CloudWatch Observability policies | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | IAM role ARN |
| role_name | IAM role name |
| role_path | IAM role path |
| role_unique_id | Stable and unique string identifying the IAM role |
| policy_names | IAM policy names |
| policy_arns | IAM policy ARNs |