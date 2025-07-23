## Modules

No Modules.

## Resources

| Name | Type |
|------|------|
| aws_s3_bucket.this | resource |
| aws_s3_bucket_acl.this | resource |
| aws_s3_bucket_versioning.this | resource |
| aws_s3_bucket_logging.this | resource |
| aws_s3_bucket_policy.this | resource |
| aws_s3_bucket_ownership_controls.this | resource |
| aws_s3_bucket_public_access_block.this | resource |
| aws_s3_bucket_lifecycle_configuration.this | resource |
| aws_s3_bucket_cors_configuration.this | resource |
| aws_s3_bucket_metric.this | resource |
| aws_s3_bucket_intelligent_tiering_configuration.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | (Optional) The canned ACL to apply. Conflicts with `grant` | `string` | `null` | no |
| attach_policy | Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy) | `bool` | `false` | no |
| block_public_acls | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| cors_rule | List of maps containing rules for Cross-Origin Resource Sharing. | `any` | `[]` | no |
| force_destroy | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| grant | An ACL policy grant. Conflicts with `acl` | `any` | `[]` | no |
| intelligent_tiering | Map containing intelligent tiering configuration. | `any` | `{` | no |
| lifecycle_rule | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| metric_configuration | Map containing bucket metric configuration. | `any` | `[]` | no |
| object_ownership | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded without the bucket-owner-full-control ACL. | `string` | `""` | no |
| policy | Bucket policy JSON document | `string` | `null` | no |
| tags | Tags to apply to the bucket | `map(string)` | `{` | no |
| create | Enable or control create | `bool` | `false` | no |
| enable_acl | Enable or control enable acl | `bool` | `false` | no |
| enable_cors | Enable or control enable cors | `bool` | `false` | no |
| enable_intelligent_tiering | Enable or control enable intelligent tiering | `bool` | `false` | no |
| enable_lifecycle | Enable or control enable lifecycle | `bool` | `false` | no |
| enable_logging | Enable or control enable logging | `bool` | `false` | no |
| enable_metrics | Enable or control enable metrics | `bool` | `false` | no |
| enable_ownership_controls | Enable or control enable ownership controls | `bool` | `false` | no |
| enable_versioning | Enable or control enable versioning | `bool` | `false` | no |
| logging_target_bucket | String for logging target bucket | `string` | `""` | no |
| logging_target_prefix | String for logging target prefix | `string` | `""` | no |
| name | Name or setting for name | `string` | `""` | no |
| use_name_prefix | Enable or control use name prefix | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket_id | The name of the bucket. |
| s3_bucket_arn | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| s3_bucket_bucket_domain_name | The bucket domain name. Will be of format bucketname.s3.amazonaws.com. |
| s3_bucket_bucket_regional_domain_name | The bucket region-specific domain name. |
| s3_bucket_hosted_zone_id | The Route 53 Hosted Zone ID for this bucket's region. |
| s3_bucket_lifecycle_configuration_rules | The lifecycle rules of the bucket, if configured. |
| s3_bucket_policy | The policy of the bucket, if configured. |
| s3_bucket_region | The AWS region this bucket resides in. |