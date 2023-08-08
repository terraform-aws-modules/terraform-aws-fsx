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
# Filesystem (common/shared variables)
################################################################################

variable "automatic_backup_retention_days" {
  description = "The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days. only valid for `PERSISTENT_1` and `PERSISTENT_2` deployment_type"
  type        = number
  default     = null
}

variable "daily_automatic_backup_start_time" {
  description = "The preferred time to take daily automatic backups, in the UTC time zone."
  type        = string
  default     = null
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

variable "kms_key_id" {
  description = "ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key"
  type        = string
  default     = null
}

################################################################################
# OpenZFS File System
################################################################################

variable "copy_tags_to_volumes" {
  description = "A boolean flag indicating whether tags for the file system should be copied to snapshots. The default value is `false`"
  type        = bool
  default     = false
}

variable "deployment_type" {
  description = "The filesystem deployment type. Only `SINGLE_AZ_1` is supported"
  type        = string
  default     = null
}

variable "root_volume_configuration" {
  description = "The configuration for the root volume of the file system. All other volumes are children or the root volume"
  type        = any
  default     = {}
}

variable "throughput_capacity" {
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048`"
  type        = number
  default     = null
}
