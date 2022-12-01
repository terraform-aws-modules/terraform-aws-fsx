################################################################################
# Lustre File System
################################################################################

resource "aws_fsx_lustre_file_system" "this" {
  count = var.create && var.create_lustre ? 1 : 0

  backup_id                         = var.backup_id
  export_path                       = var.export_path
  import_path                       = var.import_path
  imported_file_chunk_size          = var.imported_file_chunk_size
  security_group_ids                = var.security_group_ids
  storage_capacity                  = var.storage_capacity
  subnet_ids                        = var.subnet_ids
  weekly_maintenance_start_time     = var.weekly_maintenance_start_time
  deployment_type                   = var.deployment_type
  kms_key_id                        = var.kms_key_id
  per_unit_storage_throughput       = var.per_unit_storage_throughput
  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  storage_type                      = var.storage_type
  drive_cache_type                  = var.drive_cache_type
  auto_import_policy                = var.auto_import_policy
  copy_tags_to_backups              = var.copy_tags_to_backups
  data_compression_type             = var.data_compression_type
  file_system_type_version          = var.file_system_type_version

  dynamic "log_configuration" {
    for_each = length(var.log_configuration) > 0 ? [var.log_configuration] : []

    content {
      destination = try(log_configuration.value.destination, null)
      level       = try(log_configuration.value.level, null)
    }
  }

  tags = var.tags
}
