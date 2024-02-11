################################################################################
# OpenZFS File System
################################################################################

locals {
  is_multi_az = var.deployment_type == "MULTI_AZ_1"
}

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

  endpoint_ip_address_range = local.is_multi_az ? var.endpoint_ip_address_range : null
  kms_key_id                = var.kms_key_id
  preferred_subnet_id       = local.is_multi_az ? var.preferred_subnet_id : null

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

  route_table_ids               = local.is_multi_az ? var.route_table_ids : null
  security_group_ids            = local.security_group_ids
  skip_final_backup             = var.skip_final_backup
  storage_capacity              = var.storage_capacity
  storage_type                  = var.storage_type
  subnet_ids                    = var.subnet_ids
  throughput_capacity           = var.throughput_capacity
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  tags = merge(
    { terraform-aws-modules = "fsx" },
    var.tags,
    { Name = var.name },
  )

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }
}

################################################################################
# OpenZFS Volume(s)
################################################################################

resource "aws_fsx_openzfs_volume" "this" {
  for_each = { for k, v in var.volumes : k => v if var.create }

  copy_tags_to_snapshots = try(each.value.copy_tags_to_snapshots, null)
  data_compression_type  = try(each.value.data_compression_type, null)
  delete_volume_options  = try(each.value.delete_volume_options, null)
  name                   = try(each.value.name, each.key)

  dynamic "nfs_exports" {
    for_each = try([each.value.nfs_exports], [])

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

  dynamic "origin_snapshot" {
    for_each = try([each.value.origin_snapshot], [])

    content {
      copy_strategy = origin_snapshot.value.copy_strategy
      snapshot_arn  = origin_snapshot.value.snapshot_arn
    }
  }

  parent_volume_id                 = try(each.value.parent_volume_id, aws_fsx_openzfs_file_system.this[0].root_volume_id)
  read_only                        = try(each.value.read_only, null)
  record_size_kib                  = try(each.value.record_size_kib, null)
  storage_capacity_quota_gib       = try(each.value.storage_capacity_quota_gib, null)
  storage_capacity_reservation_gib = try(each.value.storage_capacity_reservation_gib, null)

  dynamic "user_and_group_quotas" {
    for_each = try(each.value.user_and_group_quotas, [])

    content {
      id                         = user_and_group_quotas.value.id
      storage_capacity_quota_gib = user_and_group_quotas.value.storage_capacity_quota_gib
      type                       = user_and_group_quotas.value.type
    }
  }

  volume_type = "OPENZFS"

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
  )

  timeouts {
    create = try(var.volumes_timeouts.create, null)
    update = try(var.volumes_timeouts.update, null)
    delete = try(var.volumes_timeouts.delete, null)
  }
}

################################################################################
# OpenZFS Snapshot(s)
################################################################################

# Root volume
resource "aws_fsx_openzfs_snapshot" "this" {
  count = var.create && var.create_snapshot ? 1 : 0

  name      = var.snapshot_name
  volume_id = aws_fsx_openzfs_file_system.this[0].root_volume_id
  tags      = var.tags

  timeouts {
    create = try(var.snapshot_timeouts.create, null)
    update = try(var.snapshot_timeouts.update, null)
    delete = try(var.snapshot_timeouts.delete, null)
  }
}

# Child volume(s)
resource "aws_fsx_openzfs_snapshot" "child" {
  for_each = { for k, v in var.volumes : k => v if var.create && try(v.create_snapshot, false) }

  name      = try(each.value.snapshot_name, each.value.name, each.key)
  volume_id = aws_fsx_openzfs_volume.this[each.key].id

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
  )

  timeouts {
    create = try(var.snapshot_timeouts.create, null)
    update = try(var.snapshot_timeouts.update, null)
    delete = try(var.snapshot_timeouts.delete, null)
  }
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.name), "")
  security_group_ids    = local.create_security_group ? concat(var.security_group_ids, aws_security_group.this[*].id) : var.security_group_ids

  default_ingress_egress_rules = {
    self_111_tcp = {
      description                  = "Remote procedure call for NFS"
      from_port                    = 111
      to_port                      = 111
      ip_protocol                  = "tcp"
      referenced_security_group_id = try(aws_security_group.this[0].id, "")
    }
    self_111_udp = {
      description                  = "Remote procedure call for NFS"
      from_port                    = 111
      to_port                      = 111
      ip_protocol                  = "udp"
      referenced_security_group_id = try(aws_security_group.this[0].id, "")
    }
    self_2049_tcp = {
      description                  = "NFS server daemon"
      from_port                    = 2049
      to_port                      = 2049
      ip_protocol                  = "tcp"
      referenced_security_group_id = try(aws_security_group.this[0].id, "")
    }
    self_2049_udp = {
      description                  = "NFS server daemon"
      from_port                    = 2049
      to_port                      = 2049
      ip_protocol                  = "udp"
      referenced_security_group_id = try(aws_security_group.this[0].id, "")
    }
    self_20001_20003_tcp = {
      description                  = "NFS mount, status monitor, and lock daemon"
      from_port                    = 20001
      to_port                      = 20003
      ip_protocol                  = "tcp"
      referenced_security_group_id = try(aws_security_group.this[0].id, "")
    }
    self_20001_20003_udp = {
      description                  = "NFS mount, status monitor, and lock daemon"
      from_port                    = 20001
      to_port                      = 20003
      ip_protocol                  = "udp"
      referenced_security_group_id = try(aws_security_group.this[0].id, "")
    }
  }

  ingress_rules = merge(var.security_group_ingress_rules, local.default_ingress_egress_rules)
  egress_rules  = merge(var.security_group_egress_rules, local.default_ingress_egress_rules)
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

  tags = merge(
    var.tags,
    var.security_group_tags,
    { Name = local.security_group_name },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in local.egress_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6                    = lookup(each.value, "cidr_ipv6", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  ip_protocol                  = try(each.value.ip_protocol, "tcp")
  prefix_list_id               = lookup(each.value, "prefix_list_id", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  to_port                      = try(each.value.to_port, null)

  tags = merge(
    var.tags,
    var.security_group_tags,
    try(each.value.tags, {}),
  )
}


resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in local.ingress_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6                    = lookup(each.value, "cidr_ipv6", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  ip_protocol                  = try(each.value.ip_protocol, "tcp")
  prefix_list_id               = lookup(each.value, "prefix_list_id", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  to_port                      = try(each.value.to_port, null)

  tags = merge(
    var.tags,
    var.security_group_tags,
    try(each.value.tags, {}),
  )
}
