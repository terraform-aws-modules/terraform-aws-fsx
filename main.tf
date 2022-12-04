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

  # ONTAP unique
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
  throughput_capacity           = var.throughput_capacity # ONTAP unique
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = var.tags
}
