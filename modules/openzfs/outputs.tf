################################################################################
# OpenZFS File System
################################################################################

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = try(aws_fsx_openzfs_file_system.this[0].arn, null)
}

output "file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = try(aws_fsx_openzfs_file_system.this[0].dns_name, null)
}

output "file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = try(aws_fsx_openzfs_file_system.this[0].id, null)
}

output "file_system_root_volume_id" {
  description = "Identifier of the root volume, e.g., `fsvol-12345678`"
  value       = try(aws_fsx_openzfs_file_system.this[0].kms_key_id, null)
}

output "file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = try(aws_fsx_openzfs_file_system.this[0].network_interface_ids, [])
}

################################################################################
# OpenZFS Volume(s)
################################################################################

output "volumes" {
  description = "A map of OpenZFS volumes created and their attributes"
  value       = aws_fsx_openzfs_volume.this
}

################################################################################
# OpenZFS Snapshot(s)
################################################################################

output "root_volume_snapshot_arn" {
  description = "Amazon Resource Name (ARN) of the root volume snapshot"
  value       = try(aws_fsx_openzfs_snapshot.this[0].arn, null)
}

output "root_volume_snapshot_id" {
  description = "ID of the root volume snapshot"
  value       = try(aws_fsx_openzfs_snapshot.this[0].id, null)
}

output "child_volumes_snapshots" {
  description = "A map of OpenZFS child volumes and their snapshots"
  value       = aws_fsx_openzfs_snapshot.child
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
