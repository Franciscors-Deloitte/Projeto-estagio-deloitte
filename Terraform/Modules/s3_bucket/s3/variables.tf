variable "acl" {
  description = "(Optional) The canned ACL to apply. Conflicts with `grant`"
  type        = string
  default     = null
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "cors_rule" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing."
  type        = any
  default     = []
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "grant" {
  description = "An ACL policy grant. Conflicts with `acl`"
  type        = any
  default     = []
}

variable "intelligent_tiering" {
  description = "Map containing intelligent tiering configuration."
  type        = any
  default     = {}
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

variable "metric_configuration" {
  description = "Map containing bucket metric configuration."
  type        = any
  default     = []
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded without the bucket-owner-full-control ACL."
  type        = string
  default     = ""
}

variable "policy" {
  description = "Bucket policy JSON document"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}

variable "create" {
  description = "Enable or control create"
  type        = bool
  default     = false
}

variable "enable_acl" {
  description = "Enable or control enable acl"
  type        = bool
  default     = false
}

variable "enable_cors" {
  description = "Enable or control enable cors"
  type        = bool
  default     = false
}

variable "enable_intelligent_tiering" {
  description = "Enable or control enable intelligent tiering"
  type        = bool
  default     = false
}

variable "enable_lifecycle" {
  description = "Enable or control enable lifecycle"
  type        = bool
  default     = false
}

variable "enable_logging" {
  description = "Enable or control enable logging"
  type        = bool
  default     = false
}

variable "enable_metrics" {
  description = "Enable or control enable metrics"
  type        = bool
  default     = false
}

variable "enable_ownership_controls" {
  description = "Enable or control enable ownership controls"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable or control enable versioning"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "String for logging target bucket"
  type        = string
  default     = ""
}

variable "logging_target_prefix" {
  description = "String for logging target prefix"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name or setting for name"
  type        = string
  default     = ""
}

variable "use_name_prefix" {
  description = "Enable or control use name prefix"
  type        = bool
  default     = false
}