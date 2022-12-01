################################################################################
# Lustre Filesystem
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
  value       = try(aws_fsx_lustre_file_system.this[0].network_interface_ids, null)
}

output "file_system_mount_name" {
  description = "The value to be used when mounting the filesystem"
  value       = try(aws_fsx_lustre_file_system.this[0].mount_name, null)
}
