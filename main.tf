################################################################################
# Lustre File System
################################################################################

resource "aws_fsx_lustre_file_system" "this" {
  count = var.create && var.create_lustre ? 1 : 0

  auto_import_policy                = var.auto_import_policy
  automatic_backup_retention_days   = var.automatic_backup_retention_days
  backup_id                         = var.backup_id
  copy_tags_to_backups              = var.copy_tags_to_backups
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  data_compression_type             = var.data_compression_type
  deployment_type                   = var.lustre_deployment_type # Lustre unique
  drive_cache_type                  = var.drive_cache_type
  export_path                       = var.export_path
  file_system_type_version          = var.file_system_type_version
  import_path                       = var.import_path
  imported_file_chunk_size          = var.imported_file_chunk_size
  kms_key_id                        = var.kms_key_id
  per_unit_storage_throughput       = var.per_unit_storage_throughput
  security_group_ids                = var.security_group_ids
  storage_capacity                  = var.storage_capacity
  storage_type                      = var.storage_type
  subnet_ids                        = var.subnet_ids
  weekly_maintenance_start_time     = var.weekly_maintenance_start_time

  dynamic "log_configuration" {
    for_each = length(var.log_configuration) > 0 ? [var.log_configuration] : []

    content {
      destination = try(log_configuration.value.destination, null)
      level       = try(log_configuration.value.level, null)
    }
  }

  tags = var.tags
}

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
# OpenZFS File System
################################################################################

resource "aws_fsx_openzfs_file_system" "this" {
  count = var.create && var.create_openzfs ? 1 : 0

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  backup_id                         = var.backup_id
  copy_tags_to_backups              = var.copy_tags_to_backups
  copy_tags_to_volumes              = var.copy_tags_to_volumes # OpenZFS unique
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  deployment_type                   = var.openzfs_deployment_type # OpenZFS unique

  # ONTAP/OpenZFS unique
  dynamic "disk_iops_configuration" {
    for_each = length(var.disk_iops_configuration) > 0 ? [var.disk_iops_configuration] : []

    content {
      iops = try(disk_iops_configuration.value.iops, null)
      mode = try(disk_iops_configuration.value.mode, null)
    }
  }

  # OpenZFS unique
  dynamic "root_volume_configuration" {
    for_each = length(var.root_volume_configuration) > 0 ? [var.root_volume_configuration] : []

    content {
      copy_tags_to_snapshots = try(root_volume_configuration.value.copy_tags_to_snapshots, null)
      data_compression_type  = try(root_volume_configuration.value.data_compression_type, null)

      dynamic "nfs_exports" {
        for_each = try([root_volume_configuration.value.nfs_exports], [])

        content {
          dynamic "client_configurations" {
            for_each = try(nfs_exports.value.client_configurations, [])

            content {
              clients = client_configurations.value.clients
              options = client_configurations.value.options
            }
          }
        }
      }

      read_only       = try(root_volume_configuration.value.read_only, null)
      record_size_kib = try(root_volume_configuration.value.record_size_kib, null)

      dynamic "user_and_group_quotas" {
        for_each = try(root_volume_configuration.value.user_and_group_quotas, [])

        content {
          id                         = user_and_group_quotas.value.id
          storage_capacity_quota_gib = user_and_group_quotas.value.storage_capacity_quota_gib
          type                       = user_and_group_quotas.value.type
        }
      }
    }
  }

  kms_key_id                    = var.kms_key_id
  security_group_ids            = var.security_group_ids
  storage_capacity              = var.storage_capacity
  storage_type                  = var.storage_type
  subnet_ids                    = var.subnet_ids
  throughput_capacity           = var.openzfs_throughput_capacity # OpenZFS unique
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = var.tags
}
