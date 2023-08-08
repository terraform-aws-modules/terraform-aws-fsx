################################################################################
# OpenZFS File System
################################################################################

resource "aws_fsx_openzfs_file_system" "this" {
  count = var.create ? 1 : 0

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  backup_id                         = var.backup_id
  copy_tags_to_backups              = var.copy_tags_to_backups
  copy_tags_to_volumes              = var.copy_tags_to_volumes
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  deployment_type                   = var.deployment_type

  dynamic "disk_iops_configuration" {
    for_each = length(var.disk_iops_configuration) > 0 ? [var.disk_iops_configuration] : []

    content {
      iops = try(disk_iops_configuration.value.iops, null)
      mode = try(disk_iops_configuration.value.mode, null)
    }
  }

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
  throughput_capacity           = var.throughput_capacity
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = var.tags
}
