################################################################################
# Lustre File System
################################################################################

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = module.fsx_lustre.file_system_arn
}

output "file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = module.fsx_lustre.file_system_dns_name
}

output "file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = module.fsx_lustre.file_system_id
}

output "file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = module.fsx_lustre.file_system_network_interface_ids
}

output "file_system_mount_name" {
  description = "The value to be used when mounting the filesystem"
  value       = module.fsx_lustre.file_system_mount_name
}

################################################################################
# Backup
################################################################################

output "backup_arn" {
  description = "Amazon Resource Name of the backup"
  value       = module.fsx_lustre.backup_arn
}

output "backup_id" {
  description = "Identifier of the backup"
  value       = module.fsx_lustre.backup_id
}

################################################################################
# Data Repository Association(s)
################################################################################

output "data_repository_associations" {
  description = "Data repository associations created and their attributes"
  value       = module.fsx_lustre.data_repository_associations
}

################################################################################
# File Cache
################################################################################

output "file_cache_arn" {
  description = "Amazon Resource Name of the file cache"
  value       = module.fsx_lustre.file_cache_arn
}

output "file_cache_id" {
  description = "Identifier of the file cache"
  value       = module.fsx_lustre.file_cache_id
}

output "file_cache_dns_name" {
  description = "The Domain Name System (DNS) name for the cache"
  value       = module.fsx_lustre.file_cache_dns_name
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.fsx_lustre.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.fsx_lustre.security_group_id
}
