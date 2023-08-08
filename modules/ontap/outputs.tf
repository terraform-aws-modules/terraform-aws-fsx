################################################################################
# File System
################################################################################

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = try(aws_fsx_ontap_file_system.this[0].arn, null)
}

output "file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = try(aws_fsx_ontap_file_system.this[0].dns_name, null)
}

output "file_system_endpoints" {
  description = "The endpoints that are used to access data or to manage the file system using the NetApp ONTAP CLI, REST API, or NetApp SnapMirror"
  value       = try(aws_fsx_ontap_file_system.this[0].endpoints, [])
}

output "file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = try(aws_fsx_ontap_file_system.this[0].id, null)
}

output "file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = try(aws_fsx_ontap_file_system.this[0].network_interface_ids, [])
}

################################################################################
# ONTAP Storage Virtual Machine(s)
################################################################################

output "storage_virtual_machines" {
  description = "A map of ONTAP storage virtual machines created and their attributes"
  value       = aws_fsx_ontap_storage_virtual_machine.this
}

################################################################################
# ONTAP Volume(s)
################################################################################

output "volues" {
  description = "A map of ONTAP volumes created and their attributes"
  value       = aws_fsx_ontap_volume.this
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
