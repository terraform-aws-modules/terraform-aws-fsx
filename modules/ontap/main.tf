################################################################################
# ONTAP File System
################################################################################

resource "aws_fsx_ontap_file_system" "this" {
  count = var.create && var.create_ontap ? 1 : 0

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  deployment_type                   = var.ontap_deployment_type # ONTAP unique

  # ONTAP/OpenZFS unique
  dynamic "disk_iops_configuration" {
    for_each = length(var.disk_iops_configuration) > 0 ? [var.disk_iops_configuration] : []

    content {
      iops = try(disk_iops_configuration.value.iops, null)
      mode = try(disk_iops_configuration.value.mode, null)
    }
  }

  endpoint_ip_address_range     = var.endpoint_ip_address_range # ONTAP unique
  fsx_admin_password            = var.fsx_admin_password        # ONTAP unique
  kms_key_id                    = var.kms_key_id
  preferred_subnet_id           = var.preferred_subnet_id # ONTAP unique
  security_group_ids            = var.security_group_ids
  route_table_ids               = var.route_table_ids # ONTAP unique
  storage_capacity              = var.storage_capacity
  storage_type                  = var.storage_type
  subnet_ids                    = var.subnet_ids
  throughput_capacity           = var.ontap_throughput_capacity # ONTAP unique
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = var.tags
}

################################################################################
# ONTAP Storage Virtual Machine
################################################################################

resource "aws_fsx_ontap_storage_virtual_machine" "this" {
  for_each = { for k, v in var.ontap_storage_virtual_machines : k => v if var.create && var.create_ontap }

  file_system_id = aws_fsx_ontap_file_system.this[0].id

  dynamic "active_directory_configuration" {
    for_each = try([each.value.active_directory_configuration], [])

    content {
      netbios_name = try(active_directory_configuration.value.netbios_name, null)

      dynamic "self_managed_active_directory_configuration" {
        for_each = try([active_directory_configuration.value.self_managed_active_directory_configuration], [])

        content {
          dns_ips                                = self_managed_active_directory_configuration.value.dns_ips
          domain_name                            = self_managed_active_directory_configuration.value.domain_name
          file_system_administrators_group       = try(self_managed_active_directory_configuration.value.file_system_administrators_group, null)
          organizational_unit_distinguished_name = try(self_managed_active_directory_configuration.value.organizational_unit_distinguished_name, null)
          password                               = self_managed_active_directory_configuration.value.password
          username                               = self_managed_active_directory_configuration.value.username
        }
      }
    }
  }

  name                       = try(each.value.name, each.key)
  root_volume_security_style = try(each.value.root_volume_security_style, null)
  svm_admin_password         = try(each.value.svm_admin_password, null)

  tags = merge(var.tags, try(each.value.tags, {}))
}

################################################################################
# ONTAP Volume
################################################################################

resource "aws_fsx_ontap_volume" "this" {
  for_each = { for k, v in var.ontap_storage_virtual_machines : k => v if var.create && var.create_ontap }

  name                       = "test"
  junction_path              = "/test"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.test.id

}
