variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Lustre File System
################################################################################

variable "auto_import_policy" {
  description = "How Amazon FSx keeps your file and directory listings up to date as you add or modify objects in your linked S3 bucket"
  type        = string
  default     = null
}

variable "automatic_backup_retention_days" {
  description = "The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days. only valid for `PERSISTENT_1` and `PERSISTENT_2` deployment_type"
  type        = number
  default     = null
}

variable "backup_id" {
  description = "The ID of the source backup to create the filesystem from"
  type        = string
  default     = null
}

variable "copy_tags_to_backups" {
  description = "A boolean flag indicating whether tags for the file system should be copied to backups"
  type        = bool
  default     = false
}

variable "daily_automatic_backup_start_time" {
  description = "The preferred time to take daily automatic backups, in the UTC time zone."
  type        = string
  default     = null
}

variable "data_compression_type" {
  description = "Sets the data compression configuration for the file system. Valid values are `LZ4` and `NONE`. Default value is `NONE`"
  type        = string
  default     = null
}

variable "deployment_type" {
  description = "The filesystem deployment type. One of: `SCRATCH_1`, `SCRATCH_2`, `PERSISTENT_1`, `PERSISTENT_2`"
  type        = string
  default     = null
}

variable "drive_cache_type" {
  description = "The type of drive cache used by `PERSISTENT_1` filesystems that are provisioned with `HDD` `storage_type`"
  type        = string
  default     = null
}

variable "export_path" {
  description = "S3 URI (with optional prefix) where the root of your Amazon FSx file system is exported"
  type        = string
  default     = null
}

variable "file_system_type_version" {
  description = "Sets the Lustre version for the file system that you're creating"
  type        = string
  default     = null
}

variable "import_path" {
  description = "S3 URI (with optional prefix) that you're using as the data repository for your FSx for Lustre file system"
  type        = string
  default     = null
}

variable "imported_file_chunk_size" {
  description = "For files imported from a data repository, this value determines the stripe count and maximum amount of data per file (in MiB) stored on a single physical disk"
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key"
  type        = string
  default     = null
}

variable "log_configuration" {
  description = "The configuration object for Amazon FSx for Lustre file systems used in the CreateFileSystem and CreateFileSystemFromBackup operations."
  type        = map(string)
  default = {
    level = "WARN_ERROR"
  }
}

variable "per_unit_storage_throughput" {
  description = "Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the `PERSISTENT_1` and `PERSISTENT_2` deployment_type"
  type        = number
  default     = null
}

variable "root_squash_configuration" {
  description = "The Lustre root squash configuration used when creating an Amazon FSx for Lustre file system. When enabled, root squash restricts root-level access from clients that try to access your file system as a root user"
  type        = any
  default     = {}
}

variable "security_group_ids" {
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces"
  type        = list(string)
  default     = []
}

variable "storage_capacity" {
  description = "The storage capacity (GiB) of the file system"
  type        = number
  default     = null
}

variable "storage_type" {
  description = "The filesystem storage type. Either `SSD` or `HDD`, defaults to `SSD`"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of IDs for the subnets that the file system will be accessible from"
  type        = list(string)
  default     = []
}

variable "weekly_maintenance_start_time" {
  description = "The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the file system"
  type        = map(string)
  default     = {}
}

###############################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group to send logs to. Note: `/aws/fsx/` is pre-pended to the name provided as this is a requirement by FSx"
  type        = string
  default     = "lustre"
}

variable "cloudwatch_log_group_use_name_prefix" {
  description = "Determines whether the log group name should be prefixed with the `cloudwatch_log_group_name` provided"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 90 days"
  type        = number
  default     = 90
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_class" {
  description = "Specified the log class of the log group. Possible values are: `STANDARD` or `INFREQUENT_ACCESS`"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_tags" {
  description = "A map of additional tags to add to the cloudwatch log group created"
  type        = map(string)
  default     = {}
}

################################################################################
# Backup
################################################################################

variable "create_backup" {
  description = "Whether to create a backup of the file system"
  type        = bool
  default     = false
}

variable "backup_tags" {
  description = "A map of additional tags to assign to the backup"
  type        = map(string)
  default     = {}
}

variable "backup_timeouts" {
  description = "Create and delete timeout configurations for the backup"
  type        = map(string)
  default     = {}
}

################################################################################
# Data Repository Association(s)
################################################################################

variable "data_repository_associations" {
  description = "A map of data repository associations to create"
  type        = any
  default     = {}
}

variable "data_repository_associations_timeouts" {
  description = "Create, update, and delete timeout configurations for the data repository associations"
  type        = map(string)
  default     = {}
}

################################################################################
# File Cache
################################################################################

variable "create_file_cache" {
  description = "Determines whether a file cache is created"
  type        = bool
  default     = false
}

variable "file_cache_copy_tags_to_data_repository_associations" {
  description = "A boolean flag indicating whether tags for the cache should be copied to data repository associations. This value defaults to `false`"
  type        = bool
  default     = null
}

variable "file_cache_type_version" {
  description = "The version for the type of cache that you're creating"
  type        = string
  default     = "2.12"
}

variable "file_cache_kms_key_id" {
  description = "Specifies the ID of the AWS Key Management Service (AWS KMS) key to use for encrypting data on an Amazon File Cache"
  type        = string
  default     = null
}

variable "file_cache_lustre_configuration" {
  description = "The configuration object for Amazon FSx for Lustre"
  type        = any
  default     = {}
}

variable "file_cache_storage_capacity" {
  description = "The storage capacity of the cache in gibibytes (GiB). Valid values are 1200 GiB, 2400 GiB, and increments of 2400 GiB"
  type        = number
  default     = null
}

################################################################################
# Security Group
################################################################################

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "Description of the security group created"
  type        = string
  default     = null
}

variable "security_group_ingress_rules" {
  description = "Security group ingress rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_egress_rules" {
  description = "Security group egress rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_tags" {
  description = "A map of additional tags to add to the security group created"
  type        = map(string)
  default     = {}
}
