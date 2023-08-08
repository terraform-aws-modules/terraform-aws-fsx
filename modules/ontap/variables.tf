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
# ONTAP File System
################################################################################

variable "deployment_type" {
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

variable "throughput_capacity" {
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048`"
  type        = number
  default     = null
}

################################################################################
# ONTAP Storage Virtual Machine
################################################################################

variable "ontap_storage_virtual_machines" {
  description = "A map of ONTAP storage virtual machine definitions to create"
  type        = any
  default     = {}
}
