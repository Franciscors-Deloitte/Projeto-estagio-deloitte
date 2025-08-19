## Modules

No Modules.

## Resources

| Name | Type | Defined In |
|------|------|------------|
| aws_iam_role_policy_attachment.this | resource | main.tf |
| aws_iam_policy.aws_gateway_controller | resource | policies.tf |
| aws_iam_role_policy_attachment.aws_gateway_controller | resource | policies.tf |
| aws_iam_policy.cert_manager | resource | policies.tf |
| aws_iam_role_policy_attachment.cert_manager | resource | policies.tf |
| aws_iam_policy.cluster_autoscaler | resource | policies.tf |
| aws_iam_role_policy_attachment.cluster_autoscaler | resource | policies.tf |
| aws_iam_policy.ebs_csi | resource | policies.tf |
| aws_iam_role_policy_attachment.ebs_csi | resource | policies.tf |
| aws_iam_policy.efs_csi | resource | policies.tf |
| aws_iam_role_policy_attachment.efs_csi | resource | policies.tf |
| aws_iam_policy.mountpoint_s3_csi | resource | policies.tf |
| aws_iam_role_policy_attachment.mountpoint_s3_csi | resource | policies.tf |
| aws_iam_policy.external_dns | resource | policies.tf |
| aws_iam_role_policy_attachment.external_dns | resource | policies.tf |
| aws_iam_policy.external_secrets | resource | policies.tf |
| aws_iam_role_policy_attachment.external_secrets | resource | policies.tf |
| aws_iam_policy.fsx_lustre_csi | resource | policies.tf |
| aws_iam_role_policy_attachment.fsx_lustre_csi | resource | policies.tf |
| aws_iam_policy.fsx_openzfs_csi | resource | policies.tf |
| aws_iam_role_policy_attachment.fsx_openzfs_csi | resource | policies.tf |
| aws_iam_policy.karpenter_controller | resource | policies.tf |
| aws_iam_role_policy_attachment.karpenter_controller | resource | policies.tf |
| aws_iam_policy.load_balancer_controller | resource | policies.tf |
| aws_iam_role_policy_attachment.load_balancer_controller | resource | policies.tf |
| aws_iam_policy.load_balancer_controller_targetgroup_only | resource | policies.tf |
| aws_iam_role_policy_attachment.load_balancer_controller_targetgroup_only | resource | policies.tf |
| aws_iam_policy.appmesh_controller | resource | policies.tf |
| aws_iam_role_policy_attachment.appmesh_controller | resource | policies.tf |
| aws_iam_policy.appmesh_envoy_proxy | resource | policies.tf |
| aws_iam_role_policy_attachment.appmesh_envoy_proxy | resource | policies.tf |
| aws_iam_policy.amazon_managed_service_prometheus | resource | policies.tf |
| aws_iam_role_policy_attachment.amazon_managed_service_prometheus | resource | policies.tf |
| aws_iam_policy.cloudwatch_observability | resource | policies.tf |
| aws_iam_role_policy_attachment.cloudwatch_observability | resource | policies.tf |
| aws_iam_policy.vpc_cni | resource | policies.tf |
| aws_iam_role_policy_attachment.vpc_cni | resource | policies.tf |
| aws_iam_policy.velero | resource | policies.tf |
| aws_iam_role_policy_attachment.velero | resource | policies.tf |
| aws_iam_policy.node_termination_handler | resource | policies.tf |
| aws_iam_role_policy_attachment.node_termination_handler | resource | policies.tf |
| aws_partition.current | Data Source | main.tf |
| aws_iam_policy_document.aws_gateway_controller | Data Source | policies.tf |
| aws_iam_policy_document.cert_manager | Data Source | policies.tf |
| aws_iam_policy_document.cluster_autoscaler | Data Source | policies.tf |
| aws_iam_policy_document.ebs_csi | Data Source | policies.tf |
| aws_iam_policy_document.efs_csi | Data Source | policies.tf |
| aws_iam_policy_document.mountpoint_s3_csi | Data Source | policies.tf |
| aws_iam_policy_document.external_dns | Data Source | policies.tf |
| aws_iam_policy_document.external_secrets | Data Source | policies.tf |
| aws_iam_policy_document.fsx_lustre_csi | Data Source | policies.tf |
| aws_iam_policy_document.fsx_openzfs_csi | Data Source | policies.tf |
| aws_iam_policy_document.karpenter_controller | Data Source | policies.tf |
| aws_iam_policy_document.load_balancer_controller | Data Source | policies.tf |
| aws_iam_policy_document.load_balancer_controller_targetgroup_only | Data Source | policies.tf |
| aws_iam_policy_document.appmesh_controller | Data Source | policies.tf |
| aws_iam_policy_document.appmesh_envoy_proxy | Data Source | policies.tf |
| aws_iam_policy_document.amazon_managed_service_prometheus | Data Source | policies.tf |
| aws_iam_policy_document.cloudwatch_observability | Data Source | policies.tf |
| aws_iam_policy_document.vpc_cni | Data Source | policies.tf |
| aws_iam_policy_document.velero | Data Source | policies.tf |
| aws_iam_policy_document.node_termination_handler | Data Source | policies.tf |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_role | Whether to create a role | `bool` | `true` | no |
| role_name | Name of IAM role | `string` | `null` | no |
| role_path | Path of IAM role | `string` | `"/"` | no |
| role_name_prefix | IAM role name prefix | `string` | `null` | no |
| role_policy_arns | ARNs of any policies to attach to the IAM role | `map(string)` | `{}` | no |
| oidc_providers | Map of OIDC providers where each provider map has `provider_arn` and `namespace_service_accounts` | `any` | `{}` | no |
| allow_self_assume_role | Determines whether to allow the role to assume itself for chained operations. See https://github.com/hashicorp/terraform-provider-aws/issues/32762 for more details and https://developer.hashicorp.com/terraform/tutorials/aws/aws-assume-role#update-to-iam-role-trust-policy-behavior/ | `bool` | `false` | no |
| iam_role_name | Name of the IAM role created via iam-assumable-role module | `string` | `n/a` | yes |
| policy_name_prefix | IAM policy name prefix | `string` | `"AmazonEKS_"` | no |
| tags | A map of tags to add the the IAM role | `map(any)` | `{}` | no |
| attach_aws_gateway_controller_policy | Determines whether to attach the AWS Gateway API controller policy to the role | `bool` | `false` | no |
| attach_cert_manager_policy | Determines whether to attach the Cert-Manager IAM policy to the role | `bool` | `false` | no |
| cert_manager_hosted_zone_arns | List of Hosted Zone ARNs that cert-manager is allowed to manage. This IAM policy grants permissions | `list(string)` | `["arn:aws:route53:::hostedzone/*"]` | no |
| attach_cluster_autoscaler_policy | Determines whether to attach the Cluster Autoscaler IAM policy to the role | `bool` | `false` | no |
| cluster_autoscaler_cluster_ids | List of EKS cluster IDs which where Cluster Autoscaler is scaled and managed | `list(string)` | `[]` | no |
| cluster_autoscaler_cluster_names | List of EKS clusters names which where Cluster Autoscaler is scaled and managed | `list(string)` | `[]` | no |
| attach_ebs_csi_policy | Determines whether to attach the EBS CSI Driver IAM policy to the role | `bool` | `false` | no |
| attach_efs_csi_policy | Determines whether to attach the EFS CSI Driver IAM policy to the role | `bool` | `false` | no |
| attach_mountpoint_s3_csi_policy | Determines whether to attach the Mountpoint S3 CSI IAM policy to the role | `bool` | `false` | no |
| attach_external_dns_policy | Determines whether to attach the ExternalDNS IAM policy to the role | `bool` | `false` | no |
| attach_external_secrets_policy | Determines whether to attach External Secrets Driver IAM policy to the role | `bool` | `false` | no |
| attach_load_balancer_controller_policy | Determines whether to attach the AWS Load Balancer Controller IAM policy to the role | `bool` | `false` | no |
| attach_load_balancer_controller_targetgroup_only_policy | Determines whether to attach ALB Controller (targetgroup only) IAM policy to the role | `bool` | `false` | no |
| load_balancer_controller_targetgroup_arns | List of targetgroup ARNs that the IAM policy allows LBC to create and manage this resource | `list(string)` | `["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]` | no |
| attach_kubecost_policy | Determines whether to attach Kubecost policy to the role. Used by Kubecost to read cloud assets and emitted metrics | `bool` | `false` | no |
| attach_amp_policy | Determines whether to attach AWS Managed Service for Prometheus IAM policy | `bool` | `false` | no |
| attach_cloudwatch_metrics_policy | Determines whether to attach Cloudwatch Metrics IAM policy | `bool` | `false` | no |
| attach_cloudwatch_logs_policy | Determines whether to attach Cloudwatch Logs IAM policy | `bool` | `false` | no |
| attach_fluentbit_logger_policy | Determines whether to attach fluent bit logger IAM policy | `bool` | `false` | no |
| attach_appmesh_controller_policy | Determines whether to attach Appmesh Controller policy to the role | `bool` | `false` | no |
| attach_appmesh_envoy_proxy_policy | Determines whether to attach Appmesh envoy proxy policy to the role | `bool` | `false` | no |
| attach_amazon_managed_service_prometheus_policy | Determines whether to attach for Prometheus IAM policy to the role | `bool` | `false` | no |
| amazon_managed_service_prometheus_workspace_arns | List of AMP workspaces ARNs to read and write metrics | `list(string)` | `["*"]` | no |
| attach_velero_policy | Determines whether to attach the Velero IAM policy to the role | `bool` | `false` | no |
| velero_s3_bucket_arns | List of S3 Bucket ARNs that Velero needs to store backups and restore cluster resources | `list(string)` | `["*"]` | no |
| attach_vpc_cni_policy | Determines whether to attach the VPC CNI IAM policy to the role | `bool` | `false` | no |
| vpc_cni_enable_cloudwatch_logs | Determines whether to enable the capability for the VPC CNI to manage CloudWatch log groups and publish network policy events | `bool` | `false` | no |
| vpc_cni_enable_ipv4 | Determines whether to enable IPv4 permissions for VPC CNI policy | `bool` | `false` | no |
| vpc_cni_enable_ipv6 | Determines whether to enable IPv6 permissions for VPC CNI policy | `bool` | `false` | no |
| attach_node_termination_handler_policy | Determines whether to attach the Node Termination Handler policy to the role | `bool` | `false` | no |
| node_termination_handler_sqs_queue_arns | List of SQS ARNs that contain node termination events | `list(string)` | `["*"]` | no |
| attach_cloudwatch_observability_policy | Determines whether to attach CloudWatch Observability IAM policies to the role | `bool` | `false` | no |
| attach_fsx_lustre_csi_policy | Determines whether to attach the FSx Lustre CSI Driver IAM policy to the role | `bool` | `false` | no |
| fsx_lustre_csi_service_role_arns | Service role ARNs to allow FSx Lustre to call S3 state. Default is assumed via their service-linked role. To customize this pass in or append roleARNs | `list(string)` | `["arn:aws:iam::*:role/aws-service-role/s3.data-source.lustre.fsx.amazonaws.com/*"]` | no |
| attach_fsx_openzfs_csi_policy | Determines whether to attach the FSx OpenZFS CSI Driver IAM policy to the role | `bool` | `false` | no |
| fsx_openzfs_csi_service_role_arns | Service role ARNs to allow OpenZFS to call AWS state. Default is assumed via their service-linked role. To customize this pass in or append roleARNs | `list(string)` | `["arn:aws:iam::*:role/aws-service-role/fsx.amazonaws.com/*"]` | no |
| attach_karpenter_controller_policy | Determines whether to attach Karpenter Controller policy to the role | `bool` | `false` | no |
| karpenter_controller_cluster_id | [Deprecated - use `karpenter_controller_cluster_name`] The ID of the cluster where Karpenter controller is provisioned/managing | `string` | `"*"` | no |
| karpenter_controller_cluster_name | The name of the cluster where Karpenter controller is provisioned/managing | `string` | `"*"` | no |
| karpenter_tag_key |  | `any` | `n/a` | yes |
| karpenter_controller_ssm_parameter_arns | List of SSM Parameter ARNs that Karpenter Controller is allowed to read. Defaults to read any SSM Parameter path under /aws/service paths | `list(string)` | `["arn:aws:ssm:*:*:parameter/aws/service/*"]` | no |
| karpenter_controller_node_iam_role_arns | List of node IAM roles that Karpenter can use to launch nodes | `list(string)` | `["*"]` | no |

## Outputs

| Name | Description |
|------|-------------|
| — | — |