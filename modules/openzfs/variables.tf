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
# OpenZFS File System
################################################################################

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

variable "copy_tags_to_volumes" {
  description = "A boolean flag indicating whether tags for the file system should be copied to snapshots. The default value is `false`"
  type        = bool
  default     = false
}

variable "daily_automatic_backup_start_time" {
  description = "The preferred time to take daily automatic backups, in the UTC time zone."
  type        = string
  default     = null
}

variable "deployment_type" {
  description = "The filesystem deployment type. Only `SINGLE_AZ_1` is supported"
  type        = string
  default     = null
}

variable "disk_iops_configuration" {
  description = "The SSD IOPS configuration for the Amazon FSx for NetApp ONTAP file system"
  type        = map(string)
  default     = {}
}

variable "endpoint_ip_address_range" {
  description = "(Multi-AZ only) Specifies the IP address range in which the endpoints to access your file system will be created"
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key"
  type        = string
  default     = null
}

variable "preferred_subnet_id" {
  description = "(Multi-AZ only) Required when deployment_type is set to `MULTI_AZ_1`. This specifies the subnet in which you want the preferred file server to be located"
  type        = string
  default     = null
}

variable "root_volume_configuration" {
  description = "The configuration for the root volume of the file system. All other volumes are children or the root volume"
  type        = any
  default     = {}
}

variable "route_table_ids" {
  description = "(Multi-AZ only) Specifies the route tables in which Amazon FSx creates the rules for routing traffic to the correct file server. You should specify all virtual private cloud (VPC) route tables associated with the subnets in which your clients are located"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces"
  type        = list(string)
  default     = []
}

variable "skip_final_backup" {
  description = "When enabled, will skip the default final backup taken when the file system is deleted"
  type        = bool
  default     = null
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

variable "throughput_capacity" {
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048`"
  type        = number
  default     = null
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

################################################################################
# OpenZFS Volume(s)
################################################################################

variable "volumes" {
  description = "A map of OpenZFS volume definitions to create"
  type        = any
  default     = {}
}

variable "volumes_timeouts" {
  description = "Create, update, and delete timeout configurations for the volumes"
  type        = map(string)
  default     = {}
}

################################################################################
# OpenZFS Snapshot(s)
################################################################################

variable "create_snapshot" {
  description = "Determines if a root volume snapshot is created"
  type        = bool
  default     = false
}

variable "snapshot_name" {
  description = "The name of the root volume snapshot"
  type        = string
  default     = null
}

variable "snapshot_timeouts" {
  description = "Create, update, and delete timeout configurations for the snapshots"
  type        = map(string)
  default     = {}
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
