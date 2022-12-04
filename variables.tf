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
# Lustre Filesystem
################################################################################

variable "create_lustre" {
  description = "Determines whether a FSx for Lustre filesystem will be created"
  type        = bool
  default     = false
}

variable "auto_import_policy" {
  description = "How Amazon FSx keeps your file and directory listings up to date as you add or modify objects in your linked S3 bucket"
  type        = string
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

variable "data_compression_type" {
  description = "Sets the data compression configuration for the file system. Valid values are `LZ4` and `NONE`. Default value is `NONE`"
  type        = string
  default     = null
}

variable "drive_cache_type" {
  description = "The type of drive cache used by `PERSISTENT_1` filesystems that are provisioned with `HDD` `storage_type`"
  type        = string
  default     = null
}

variable "file_system_type_version" {
  description = "Sets the Lustre version for the file system that you're creating"
  type        = string
  default     = null
}

variable "lustre_deployment_type" {
  description = "The filesystem deployment type. One of: `SCRATCH_1`, `SCRATCH_2`, `PERSISTENT_1`, `PERSISTENT_2`"
  type        = string
  default     = null
}

variable "export_path" {
  description = "S3 URI (with optional prefix) where the root of your Amazon FSx file system is exported"
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

variable "log_configuration" {
  description = "The configuration object for Amazon FSx for Lustre file systems used in the CreateFileSystem and CreateFileSystemFromBackup operations."
  type        = map(string)
  default     = {}
}

variable "per_unit_storage_throughput" {
  description = "Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the `PERSISTENT_1` and `PERSISTENT_2` deployment_type"
  type        = number
  default     = null
}

################################################################################
# ONTAP File System
################################################################################

variable "create_ontap" {
  description = "Determines whether a FSx ONTAP filesystem will be created"
  type        = bool
  default     = false
}

variable "ontap_deployment_type" {
  description = "The filesystem deployment type. One of: `MULTI_AZ_1` or `SINGLE_AZ_1`"
  type        = string
  default     = null
}

variable "disk_iops_configuration" {
  description = "The SSD IOPS configuration for the Amazon FSx for NetApp ONTAP file system"
  type        = map(string)
  default     = {}
}

variable "endpoint_ip_address_range" {
  description = "Specifies the IP address range in which the endpoints to access your file system will be created. By default, Amazon FSx selects an unused IP address range for you from the 198.19.* range"
  type        = string
  default     = null
}

variable "fsx_admin_password" {
  description = "The ONTAP administrative password for the fsxadmin user that you can use to administer your file system using the ONTAP CLI and REST API"
  type        = string
  default     = null
}

variable "preferred_subnet_id" {
  description = "The ID for a subnet. A subnet is a range of IP addresses in your virtual private cloud (VPC)"
  type        = string
  default     = ""
}

variable "route_table_ids" {
  description = "Specifies the VPC route tables in which your file system's endpoints will be created. You should specify all VPC route tables associated with the subnets in which your clients are located. By default, Amazon FSx selects your VPC's default route table"
  type        = list(string)
  default     = []
}

variable "ontap_throughput_capacity" {
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048`"
  type        = number
  default     = null
}

################################################################################
# ONTAP File System
################################################################################

variable "create_openzfs" {
  description = "Determines whether a FSx OpenZFS filesystem will be created"
  type        = bool
  default     = false
}

variable "copy_tags_to_volumes" {
  description = "A boolean flag indicating whether tags for the file system should be copied to snapshots. The default value is `false`"
  type        = bool
  default     = false
}

variable "openzfs_deployment_type" {
  description = "The filesystem deployment type. Only `SINGLE_AZ_1` is supported"
  type        = string
  default     = null
}

variable "root_volume_configuration" {
  description = "The configuration for the root volume of the file system. All other volumes are children or the root volume"
  type        = any
  default     = {}
}

variable "openzfs_throughput_capacity" {
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048`"
  type        = number
  default     = null
}
