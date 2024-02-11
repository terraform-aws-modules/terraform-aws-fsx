################################################################################
# Lustre File System
################################################################################

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = try(aws_fsx_lustre_file_system.this[0].arn, null)
}

output "file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = try(aws_fsx_lustre_file_system.this[0].dns_name, null)
}

output "file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = try(aws_fsx_lustre_file_system.this[0].id, null)
}

output "file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = try(aws_fsx_lustre_file_system.this[0].network_interface_ids, [])
}

output "file_system_mount_name" {
  description = "The value to be used when mounting the filesystem"
  value       = try(aws_fsx_lustre_file_system.this[0].mount_name, null)
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = try(aws_cloudwatch_log_group.this[0].name, null)
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = try(aws_cloudwatch_log_group.this[0].arn, null)
}

################################################################################
# Backup
################################################################################

output "backup_arn" {
  description = "Amazon Resource Name of the backup"
  value       = try(aws_fsx_backup.this[0].arn, null)
}

output "backup_id" {
  description = "Identifier of the backup"
  value       = try(aws_fsx_backup.this[0].id, null)
}

################################################################################
# Data Repository Association(s)
################################################################################

output "data_repository_associations" {
  description = "Data repository associations created and their attributes"
  value       = aws_fsx_data_repository_association.this
}

################################################################################
# File Cache
################################################################################

output "file_cache_arn" {
  description = "Amazon Resource Name of the file cache"
  value       = try(aws_fsx_file_cache.this[0].arn, null)
}

output "file_cache_id" {
  description = "Identifier of the file cache"
  value       = try(aws_fsx_file_cache.this[0].id, null)
}

output "file_cache_dns_name" {
  description = "The Domain Name System (DNS) name for the cache"
  value       = try(aws_fsx_file_cache.this[0].dns_name, null)
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = try(aws_security_group.this[0].arn, null)
}

output "security_group_id" {
  description = "ID of the security group"
  value       = try(aws_security_group.this[0].id, null)
}
