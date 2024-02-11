################################################################################
# ONTAP File System
################################################################################

resource "aws_fsx_ontap_file_system" "this" {
  count = var.create ? 1 : 0

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  deployment_type                   = var.deployment_type

  dynamic "disk_iops_configuration" {
    for_each = length(var.disk_iops_configuration) > 0 ? [var.disk_iops_configuration] : []

    content {
      iops = try(disk_iops_configuration.value.iops, null)
      mode = try(disk_iops_configuration.value.mode, null)
    }
  }

  endpoint_ip_address_range       = var.endpoint_ip_address_range
  fsx_admin_password              = var.fsx_admin_password
  ha_pairs                        = var.ha_pairs
  kms_key_id                      = var.kms_key_id
  preferred_subnet_id             = var.preferred_subnet_id
  route_table_ids                 = var.route_table_ids
  security_group_ids              = local.security_group_ids
  storage_capacity                = var.storage_capacity
  storage_type                    = var.storage_type
  subnet_ids                      = var.subnet_ids
  throughput_capacity             = var.ha_pairs == null ? var.throughput_capacity : null
  throughput_capacity_per_ha_pair = var.ha_pairs != null ? var.throughput_capacity_per_ha_pair : null
  weekly_maintenance_start_time   = var.weekly_maintenance_start_time

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
# ONTAP Storage Virtual Machine(s)
################################################################################

resource "aws_fsx_ontap_storage_virtual_machine" "this" {
  for_each = { for k, v in var.storage_virtual_machines : k => v if var.create }

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

  file_system_id             = aws_fsx_ontap_file_system.this[0].id
  name                       = try(each.value.name, each.key)
  root_volume_security_style = try(each.value.root_volume_security_style, null)
  svm_admin_password         = try(each.value.svm_admin_password, null)

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
  )

  timeouts {
    create = try(var.storage_virtual_machines_timeouts.create, null)
    update = try(var.storage_virtual_machines_timeouts.update, null)
    delete = try(var.storage_virtual_machines_timeouts.delete, null)
  }
}

################################################################################
# ONTAP Volume(s)
################################################################################

locals {
  # This allows volumes to be specified under the storage virtual machine definition
  volumes = flatten([
    for machine_key, machine_values in var.storage_virtual_machines : [
      for volume_key, volume_values in lookup(machine_values, "volumes", {}) :
      merge(volume_values, {
        machine_key = machine_key
        volume_key  = volume_key
      })
    ]
  ])
}

resource "aws_fsx_ontap_volume" "this" {
  for_each = { for v in local.volumes : "${v.machine_key}_${v.volume_key}" => v if var.create }

  bypass_snaplock_enterprise_retention = try(each.value.bypass_snaplock_enterprise_retention, null)
  copy_tags_to_backups                 = try(each.value.copy_tags_to_backups, null)
  junction_path                        = try(each.value.junction_path, null)
  name                                 = try(each.value.name, each.key)
  ontap_volume_type                    = try(each.value.ontap_volume_type, null)
  security_style                       = try(each.value.security_style, null)
  size_in_megabytes                    = each.value.size_in_megabytes
  skip_final_backup                    = try(each.value.skip_final_backup, null)

  dynamic "snaplock_configuration" {
    for_each = try([each.value.snaplock_configuration], [])

    content {
      audit_log_volume = try(snaplock_configuration.value.audit_log_volume, null)

      dynamic "autocommit_period" {
        for_each = try([snaplock_configuration.value.autocommit_period], [])

        content {
          type  = try(autocommit_period.value.type, null)
          value = try(autocommit_period.value.value, null)
        }
      }

      privileged_delete = try(snaplock_configuration.value.privileged_delete, null)

      dynamic "retention_period" {
        for_each = try([snaplock_configuration.value.retention_period], [])

        content {
          dynamic "default_retention" {
            for_each = try([retention_period.value.default_retention], [])

            content {
              type  = try(default_retention.value.type, null)
              value = try(default_retention.value.value, null)
            }

          }

          dynamic "maximum_retention" {
            for_each = try([retention_period.value.maximum_retention], [])

            content {
              type  = try(maximum_retention.value.type, null)
              value = try(maximum_retention.value.value, null)
            }
          }

          dynamic "minimum_retention" {
            for_each = try([retention_period.value.minimum_retention], [])

            content {
              type  = try(minimum_retention.value.type, null)
              value = try(minimum_retention.value.value, null)
            }
          }
        }
      }

      snaplock_type              = snaplock_configuration.value.snaplock_type
      volume_append_mode_enabled = try(snaplock_configuration.value.volume_append_mode_enabled, null)
    }
  }

  snapshot_policy            = try(each.value.snapshot_policy, null)
  storage_efficiency_enabled = try(each.value.storage_efficiency_enabled, null)
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.this[each.value.machine_key].id

  dynamic "tiering_policy" {
    for_each = try([each.value.tiering_policy], [])

    content {
      cooling_period = try(tiering_policy.value.cooling_period, null)
      name           = try(tiering_policy.value.name, null)
    }
  }

  volume_type = "ONTAP"

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
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.name), "")
  security_group_ids    = local.create_security_group ? concat(var.security_group_ids, aws_security_group.this[*].id) : var.security_group_ids
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
  for_each = { for k, v in var.security_group_egress_rules : k => v if local.create_security_group }

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
  for_each = { for k, v in var.security_group_ingress_rules : k => v if local.create_security_group }

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
