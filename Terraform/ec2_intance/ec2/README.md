## Resources

| Name | Type |
|------|------|
| aws_instance.this | resource |
| aws_ebs_volume.this | resource |
| aws_volume_attachment.this | resource |
| aws_eip.this| resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create an instance | `bool` | `true` | no |
| ami | ID of AMI to use for the instance | `string` | `null` | no |
| iam_instance_profile | IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile | `string` | `null` | no |
| instance_type | The type of instance to start | `string` | `"t3.micro"` | no |
| key_name | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | `null` | no |
| associate_public_ip_address | Whether to associate a public IP address with an instance in a VPC | `bool` | `null` | no |
| availability_zone | AZ to start the instance in | `string` | `null` | no |
| private_ip | Private IP address to associate with the instance in a VPC | `string` | `null` | no |
| subnet_id | The VPC Subnet ID to launch in | `string` | `null` | no |
| vpc_security_group_ids | A list of security group IDs to associate with | `list(string)` | `[]` | no |
| disable_api_termination | If true, enables EC2 Instance Termination Protection | `bool` | `null` | no |
| user_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead | `string` | `null` | no |
| enable_monitoring | Whether to enable detailed monitoring for the instance | `bool` | `false` | no |
| tags | A mapping of tags to assign to the resources | `map(string)` | `{` | no |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no |
| create_ebs | Whether to create and attach an additional EBS volume | `bool` | `false` | no |
| ebs_volume_size | Size of the additional EBS volume in GiB | `number` | `10` | no |
| ebs_volume_type | Type of the additional EBS volume | `string` | `"gp3"` | no |
| ebs_device_name | Device name to attach the additional EBS volume (e.g., /dev/sdf) | `string` | `"/dev/sdf"` | no |
| root_volume_size | Size of the root volume in GiB | `number` | `8` | no |
| root_volume_type | Type of the root volume (e.g., gp2, gp3, io1, etc.) | `string` | `"gp3"` | no |
| attach_eip | Whether to allocate and attach an Elastic IP to the instance | `bool` | `false` | no |


## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the instance |
| instance_state | The state of the instance |
| private_ip | The private IP address assigned to the instance |
| public_ip | The public IP address assigned to the instance, if applicable |
| ami | AMI ID that was used to create the instance |
| ebs_volumes | Map of EBS volumes created and their attributes |
| root_block_device | Root block device information |