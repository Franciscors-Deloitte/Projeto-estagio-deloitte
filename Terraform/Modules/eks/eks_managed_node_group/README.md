## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_eks_node_group.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the managed node group | `bool` | `true` | no |
| name | Name of the node group | `string` | `null` | yes |
| cluster_name | Name of the EKS cluster | `string` | `null` | yes |
| tags | Tags to apply | `map(string)` | `{` | no |
| labels | Labels to apply | `map(string)` | `{` | no |
| subnet_ids | Subnets for node group | `list(string)` | `null` | yes |
| node_role_arn | IAM role ARN for the node group | `string` | `null` | yes |
| instance_types | Instance types for the nodes | `list(string)` | `["t3.medium"]` | no |
| disk_size | Disk size in GiB | `number` | `20` | no |
| capacity_type | Capacity type (ON_DEMAND or SPOT) | `string` | `"ON_DEMAND"` | no |
| desired_size | Desired number of nodes | `number` | `null` | yes |
| min_size | Minimum number of nodes | `number` | `null` | yes |
| max_size | Maximum number of nodes | `number` | `null` | yes |
| version | Kubernetes version | `string` | `null` | no |
| release_version | AMI release version | `string` | `null` | no |
| ami_type | AMI type for the node group | `string` | `null` | no |
| max_unavailable | Max unavailable nodes during update | `number` | `1` | no |
| depends_on | Explicit resource dependencies | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| node_group_arn | Amazon Resource Name (ARN) of the EKS Node Group |
| node_group_id | EKS Cluster name and EKS Node Group name separated by a colon (:) |
| node_group_resources | List of objects containing information about underlying resources |
| node_group_autoscaling_group_names | List of the autoscaling group names |
| node_group_status | Status of the EKS Node Group |
| node_group_labels | Map of labels applied to the node group |
| node_group_iam_role_arn | IAM Role ARN associada ao EKS Managed Node Group |