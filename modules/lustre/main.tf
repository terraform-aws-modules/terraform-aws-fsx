################################################################################
# Lustre File System
################################################################################

resource "aws_fsx_lustre_file_system" "this" {
  count = var.create ? 1 : 0

  auto_import_policy                = var.auto_import_policy
  automatic_backup_retention_days   = var.automatic_backup_retention_days
  backup_id                         = var.backup_id
  copy_tags_to_backups              = var.copy_tags_to_backups
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  data_compression_type             = var.data_compression_type
  deployment_type                   = var.deployment_type
  drive_cache_type                  = var.drive_cache_type
  export_path                       = var.export_path
  file_system_type_version          = var.file_system_type_version
  import_path                       = var.import_path
  imported_file_chunk_size          = var.imported_file_chunk_size
  kms_key_id                        = var.kms_key_id

  dynamic "log_configuration" {
    for_each = length(var.log_configuration) > 0 ? [var.log_configuration] : []

    content {
      destination = try(log_configuration.value.destination, null)
      level       = try(log_configuration.value.level, null)
    }
  }

  per_unit_storage_throughput = var.per_unit_storage_throughput

  dynamic "root_squash_configuration" {
    for_each = length(var.root_squash_configuration) > 0 ? [var.root_squash_configuration] : []

    content {
      no_squash_nids = try(root_squash_configuration.value.no_squash_nids, null)
      root_squash    = try(root_squash_configuration.value.root_squash, null)
    }
  }

  security_group_ids            = var.security_group_ids
  storage_capacity              = var.storage_capacity
  storage_type                  = var.storage_type
  subnet_ids                    = var.subnet_ids
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = var.tags
}

################################################################################
# Backup
################################################################################

resource "aws_fsx_backup" "this" {
  count = var.create && var.create_backup ? 1 : 0

  file_system_id = aws_fsx_lustre_file_system.this[0].id
  tags           = merge(var.tags, var.backup_tags)
}

################################################################################
# Data Repository Association(s)
################################################################################

resource "aws_fsx_data_repository_association" "this" {
  for_each = { for k, v in var.data_repository_associations : k => v if var.create }

  batch_import_meta_data_on_create = try(each.value.batch_import_meta_data_on_create, null)
  data_repository_path             = each.value.data_repository_path
  delete_data_in_filesystem        = try(each.value.delete_data_in_filesystem, null)
  file_system_id                   = aws_fsx_lustre_file_system.this[0].id
  file_system_path                 = each.value.file_system_path
  imported_file_chunk_size         = try(each.value.imported_file_chunk_size, null)

  dynamic "s3" {
    for_each = try([each.value.s3], [])

    content {
      dynamic "auto_export_policy" {
        for_each = try([s3.value.auto_export_policy], [])

        content {
          events = try(auto_export_policy.value.events, null)
        }
      }

      dynamic "auto_import_policy" {
        for_each = try([s3.value.auto_import_policy], [])

        content {
          events = try(auto_import_policy.value.events, null)
        }
      }
    }
  }

  tags = merge(var.tags, try(each.value.tags, {}))
}

################################################################################
# File Cache
################################################################################

resource "aws_fsx_file_cache" "this" {
  count = var.create && var.create_file_cache ? 1 : 0

  copy_tags_to_data_repository_associations = var.file_cache_copy_tags_to_data_repository_associations

  dynamic "data_repository_association" {
    for_each = length(var.data_repository_associations) > 0 ? { for k, v in var.data_repository_associations : k => v if try(v.create_file_cache, true) } : []

    content {
      data_repository_path           = each.value.data_repository_path
      data_repository_subdirectories = try(each.value.data_repository_subdirectories, null)
      file_cache_path                = each.value.file_cache_path

      dynamic "nfs" {
        for_each = try(each.value.nfs, [])

        content {
          dns_ips = try(nfs.value.dns_ips, null)
          version = nfs.value.version
        }
      }

      tags = merge(var.tags, try(each.value.tags, {}))
    }
  }

  file_cache_type         = "LUSTRE"
  file_cache_type_version = var.file_cache_type_version
  kms_key_id              = var.file_cache_kms_key_id

  dynamic "lustre_configuration" {
    for_each = length(var.file_cache_lustre_configuration) > 0 ? var.file_cache_lustre_configuration : []

    content {
      deployment_type = try(lustre_configuration.value.deployment_type, "CACHE_1")

      dynamic "metadata_configuration" {
        for_each = length(lustre_configuration.value.metadata_configuration) > 0 ? lustre_configuration.value.metadata_configuration : []

        content {
          storage_capacity = metadata_configuration.value.storage_capacity
        }
      }

      per_unit_storage_throughput   = lustre_configuration.value.per_unit_storage_throughput
      weekly_maintenance_start_time = try(lustre_configuration.value.weekly_maintenance_start_time, null)
    }
  }

  security_group_ids = var.security_group_ids
  storage_capacity   = var.file_cache_storage_capacity
  subnet_ids         = var.subnet_ids

  tags = var.tags
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
}

data "aws_subnet" "this" {
  count = local.create_security_group ? 1 : 0

  id = element(var.subnet_ids, 0)
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : var.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${var.security_group_name}-" : null
  description = var.security_group_description
  vpc_id      = data.aws_subnet.this[0].vpc_id

  tags = merge(var.tags, var.security_group_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in var.security_group_egress_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6                    = lookup(each.value, "cidr_ipv6", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  ip_protocol                  = try(each.value.ip_protocol, null)
  prefix_list_id               = lookup(each.value, "prefix_list_id", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  to_port                      = try(each.value.to_port, null)

  tags = merge(var.tags, var.security_group_tags, try(each.value.tags, {}))
}


resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in var.security_group_ingress_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6                    = lookup(each.value, "cidr_ipv6", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  ip_protocol                  = try(each.value.ip_protocol, null)
  prefix_list_id               = lookup(each.value, "prefix_list_id", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  to_port                      = try(each.value.to_port, null)

  tags = merge(var.tags, var.security_group_tags, try(each.value.tags, {}))
}
