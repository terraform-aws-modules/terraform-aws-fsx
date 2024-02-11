################################################################################
# OpenZFS File System
################################################################################

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = module.fsx_openzfs.file_system_arn
}

output "file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = module.fsx_openzfs.file_system_dns_name
}

output "file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = module.fsx_openzfs.file_system_id
}

output "file_system_root_volume_id" {
  description = "Identifier of the root volume, e.g., `fsvol-12345678`"
  value       = module.fsx_openzfs.file_system_root_volume_id
}

output "file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = module.fsx_openzfs.file_system_network_interface_ids
}

################################################################################
# OpenZFS Volume(s)
################################################################################

output "volumes" {
  description = "A map of OpenZFS volumes created and their attributes"
  value       = module.fsx_openzfs.volumes
}

################################################################################
# OpenZFS Snapshot(s)
################################################################################

output "root_volume_snapshot_arn" {
  description = "Amazon Resource Name (ARN) of the root volume snapshot"
  value       = module.fsx_openzfs.root_volume_snapshot_arn
}

output "root_volume_snapshot_id" {
  description = "ID of the root volume snapshot"
  value       = module.fsx_openzfs.root_volume_snapshot_id
}

output "child_volumes_snapshots" {
  description = "A map of OpenZFS child volumes and their snapshots"
  value       = module.fsx_openzfs.child_volumes_snapshots
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.fsx_openzfs.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.fsx_openzfs.security_group_id
}
