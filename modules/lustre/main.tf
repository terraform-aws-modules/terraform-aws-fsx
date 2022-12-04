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

  per_unit_storage_throughput   = var.per_unit_storage_throughput
  security_group_ids            = var.security_group_ids
  storage_capacity              = var.storage_capacity
  storage_type                  = var.storage_type
  subnet_ids                    = var.subnet_ids
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = var.tags
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.name), "")
}

data "aws_subnet" "this" {
  count = local.create_security_group ? 1 : 0

  id = element(var.subnet_ids, 0)
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
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
