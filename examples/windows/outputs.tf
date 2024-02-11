################################################################################
# Windows File System
################################################################################

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = module.fsx_windows.file_system_arn
}

output "file_system_dns_name" {
  description = "DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com`"
  value       = module.fsx_windows.file_system_dns_name
}

output "file_system_id" {
  description = "Identifier of the file system, e.g., `fs-12345678`"
  value       = module.fsx_windows.file_system_id
}

output "file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface"
  value       = module.fsx_windows.file_system_network_interface_ids
}

output "file_system_preferred_file_server_ip" {
  description = "IP address of the primary, or preferred, file server"
  value       = module.fsx_windows.file_system_preferred_file_server_ip
}

output "file_system_remote_administration_endpoint" {
  description = "For `MULTI_AZ_1` deployment types, use this endpoint when performing administrative tasks on the file system using Amazon FSx Remote PowerShell. For `SINGLE_AZ_1` deployment types, this is the DNS name of the file system"
  value       = module.fsx_windows.file_system_remote_administration_endpoint
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.fsx_windows.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.fsx_windows.cloudwatch_log_group_arn
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.fsx_windows.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.fsx_windows.security_group_id
}
