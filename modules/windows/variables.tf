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
# Windows File System
################################################################################

variable "active_directory_id" {
  description = "The ID for an existing Microsoft Active Directory instance that the file system should join when it's created. Cannot be specified with `self_managed_active_directory`"
  type        = string
  default     = null
}

variable "aliases" {
  description = "An array DNS alias names that you want to associate with the Amazon FSx file system"
  type        = list(string)
  default     = []
}

variable "audit_log_configuration" {
  description = "The configuration that Amazon FSx for Windows File Server uses to audit and log user accesses of files, folders, and file shares on the Amazon FSx for Windows File Server file system"
  type        = any
  default = {
    file_access_audit_log_level       = "FAILURE_ONLY"
    file_share_access_audit_log_level = "FAILURE_ONLY"
  }
}

variable "automatic_backup_retention_days" {
  description = "The number of days to retain automatic backups. Minimum of `0` and maximum of `90`. Defaults to `7`. Set to `0` to disable"
  type        = number
  default     = null
}

variable "backup_id" {
  description = "The ID of the source backup to create the filesystem from"
  type        = string
  default     = null
}

variable "copy_tags_to_backups" {
  description = "A boolean flag indicating whether tags on the file system should be copied to backups. Defaults to `false`"
  type        = bool
  default     = null
}

variable "daily_automatic_backup_start_time" {
  description = "The preferred time (in `HH:MM` format) to take daily automatic backups, in the UTC time zone"
  type        = string
  default     = null
}

variable "deployment_type" {
  description = "Specifies the file system deployment type, valid values are `MULTI_AZ_1`, `SINGLE_AZ_1` and `SINGLE_AZ_2`. Default value is `SINGLE_AZ_1`"
  type        = string
  default     = null
}

variable "disk_iops_configuration" {
  description = "The SSD IOPS configuration for the Amazon FSx for Windows File Server file system"
  type        = any
  default     = {}
}

variable "kms_key_id" {
  description = "ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the file system"
  type        = string
  default     = ""
}

variable "preferred_subnet_id" {
  description = "Specifies the subnet in which you want the preferred file server to be located. Required for when deployment type is `MULTI_AZ_1`"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces"
  type        = list(string)
  default     = []
}

variable "self_managed_active_directory" {
  description = "Configuration block that Amazon FSx uses to join the Windows File Server instance to your self-managed (including on-premises) Microsoft Active Directory (AD) directory. Cannot be specified with `active_directory_id`"
  type        = any
  default     = {}
}

variable "skip_final_backup" {
  description = " When enabled, will skip the default final backup taken when the file system is deleted. This configuration must be applied separately before attempting to delete the resource to have the desired behavior. Defaults to `false`"
  type        = bool
  default     = null
}

variable "storage_capacity" {
  description = "Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536. If the storage type is set to HDD the minimum value is `2000`. Required when not creating filesystem for a backup"
  type        = number
  default     = null
}

variable "storage_type" {
  description = "Specifies the storage type, Valid values are `SSD` and `HDD`. `HDD` is supported on `SINGLE_AZ_2` and `MULTI_AZ_1` Windows file system deployment types. Default value is `SSD`"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of IDs for the subnets that the file system will be accessible from. To specify more than a single subnet set `deployment_type` to `MULTI_AZ_1`"
  type        = list(string)
  default     = []
}

variable "throughput_capacity" {
  description = "Throughput (megabytes per second) of the file system in power of `2` increments. Minimum of `8` and maximum of `2048`"
  type        = number
  default     = null
}

variable "weekly_maintenance_start_time" {
  description = "The preferred start time (in `d:HH:MM` format) to perform weekly maintenance, in the UTC time zone"
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
  description = "Determines whether a log group is created"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group to send logs to. Note: `/aws/fsx/` is pre-pended to the name provided as this is a requirement by FSx"
  type        = string
  default     = null
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

variable "cloudwatch_log_group_skip_destroy" {
  description = "Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state"
  type        = bool
  default     = null
}

variable "cloudwatch_log_group_tags" {
  description = "A map of additional tags to add to the cloudwatch log group created"
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
  default = {
    ipv4 = {
      description = "Allow all outbound traffic by default"
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
    ipv6 = {
      description = "Allow all outbound traffic by default"
      ip_protocol = "-1"
      cidr_ipv6   = "::/0"
    }
  }
}

variable "security_group_tags" {
  description = "A map of additional tags to add to the security group created"
  type        = map(string)
  default     = {}
}
