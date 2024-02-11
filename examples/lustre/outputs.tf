################################################################################
# FSx Lustre - Persistent 1
################################################################################

output "persistent_1_file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = module.fsx_lustre_persistent_1.file_system_arn
}

output "persistent_1_file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = module.fsx_lustre_persistent_1.file_system_dns_name
}

output "persistent_1_file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = module.fsx_lustre_persistent_1.file_system_id
}

output "persistent_1_file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = module.fsx_lustre_persistent_1.file_system_network_interface_ids
}

output "persistent_1_file_system_mount_name" {
  description = "The value to be used when mounting the filesystem"
  value       = module.fsx_lustre_persistent_1.file_system_mount_name
}

output "persistent_1_cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.fsx_lustre_persistent_1.cloudwatch_log_group_name
}

output "persistent_1_cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.fsx_lustre_persistent_1.cloudwatch_log_group_arn
}

output "persistent_1_backup_arn" {
  description = "Amazon Resource Name of the backup"
  value       = module.fsx_lustre_persistent_1.backup_arn
}

output "persistent_1_backup_id" {
  description = "Identifier of the backup"
  value       = module.fsx_lustre_persistent_1.backup_id
}

output "persistent_1_data_repository_associations" {
  description = "Data repository associations created and their attributes"
  value       = module.fsx_lustre_persistent_1.data_repository_associations
}

output "persistent_1_file_cache_arn" {
  description = "Amazon Resource Name of the file cache"
  value       = module.fsx_lustre_persistent_1.file_cache_arn
}

output "persistent_1_file_cache_id" {
  description = "Identifier of the file cache"
  value       = module.fsx_lustre_persistent_1.file_cache_id
}

output "persistent_1_file_cache_dns_name" {
  description = "The Domain Name System (DNS) name for the cache"
  value       = module.fsx_lustre_persistent_1.file_cache_dns_name
}

output "persistent_1_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.fsx_lustre_persistent_1.security_group_arn
}

output "persistent_1_security_group_id" {
  description = "ID of the security group"
  value       = module.fsx_lustre_persistent_1.security_group_id
}

################################################################################
# FSx Lustre - Persistent 2
################################################################################

output "persistent_2_file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = module.fsx_lustre_persistent_2.file_system_arn
}

output "persistent_2_file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = module.fsx_lustre_persistent_2.file_system_dns_name
}

output "persistent_2_file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = module.fsx_lustre_persistent_2.file_system_id
}

output "persistent_2_file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = module.fsx_lustre_persistent_2.file_system_network_interface_ids
}

output "persistent_2_file_system_mount_name" {
  description = "The value to be used when mounting the filesystem"
  value       = module.fsx_lustre_persistent_2.file_system_mount_name
}

output "persistent_2_cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.fsx_lustre_persistent_2.cloudwatch_log_group_name
}

output "persistent_2_cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.fsx_lustre_persistent_2.cloudwatch_log_group_arn
}

output "persistent_2_backup_arn" {
  description = "Amazon Resource Name of the backup"
  value       = module.fsx_lustre_persistent_2.backup_arn
}

output "persistent_2_backup_id" {
  description = "Identifier of the backup"
  value       = module.fsx_lustre_persistent_2.backup_id
}

output "persistent_2_data_repository_associations" {
  description = "Data repository associations created and their attributes"
  value       = module.fsx_lustre_persistent_2.data_repository_associations
}

output "persistent_2_file_cache_arn" {
  description = "Amazon Resource Name of the file cache"
  value       = module.fsx_lustre_persistent_2.file_cache_arn
}

output "persistent_2_file_cache_id" {
  description = "Identifier of the file cache"
  value       = module.fsx_lustre_persistent_2.file_cache_id
}

output "persistent_2_file_cache_dns_name" {
  description = "The Domain Name System (DNS) name for the cache"
  value       = module.fsx_lustre_persistent_2.file_cache_dns_name
}

output "persistent_2_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.fsx_lustre_persistent_2.security_group_arn
}

output "persistent_2_security_group_id" {
  description = "ID of the security group"
  value       = module.fsx_lustre_persistent_2.security_group_id
}
