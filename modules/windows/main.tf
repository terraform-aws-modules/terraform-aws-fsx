################################################################################
# Windows File System
################################################################################

resource "aws_fsx_windows_file_system" "this" {
  count = var.create ? 1 : 0

  active_directory_id = var.active_directory_id
  aliases             = var.aliases

  dynamic "audit_log_configuration" {
    for_each = length(var.audit_log_configuration) > 0 ? [var.audit_log_configuration] : []

    content {
      audit_log_destination             = try(audit_log_configuration.value.audit_log_destination, aws_cloudwatch_log_group.this[0].arn, null)
      file_access_audit_log_level       = try(audit_log_configuration.value.file_access_audit_log_level, null)
      file_share_access_audit_log_level = try(audit_log_configuration.value.file_share_access_audit_log_level, null)
    }
  }

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  backup_id                         = var.backup_id
  copy_tags_to_backups              = var.copy_tags_to_backups
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  deployment_type                   = var.deployment_type

  dynamic "disk_iops_configuration" {
    for_each = length(var.disk_iops_configuration) > 0 ? [var.disk_iops_configuration] : []

    content {
      iops = try(disk_iops_configuration.value.iops, null)
      mode = try(disk_iops_configuration.value.mode, null)
    }
  }

  kms_key_id          = var.kms_key_id
  preferred_subnet_id = var.preferred_subnet_id
  security_group_ids  = local.security_group_ids

  dynamic "self_managed_active_directory" {
    for_each = length(var.self_managed_active_directory) > 0 ? [var.self_managed_active_directory] : []

    content {
      dns_ips                                = self_managed_active_directory.value.dns_ips
      domain_name                            = self_managed_active_directory.value.domain_name
      file_system_administrators_group       = try(self_managed_active_directory.value.file_system_administrators_group, null)
      organizational_unit_distinguished_name = try(self_managed_active_directory.value.organizational_unit_distinguished_name, null)
      password                               = self_managed_active_directory.value.password
      username                               = self_managed_active_directory.value.username
    }
  }

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
# CloudWatch Log Group
################################################################################

locals {
  log_group_name = "/aws/fsx/${try(coalesce(var.cloudwatch_log_group_name, var.name), "")}"
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_cloudwatch_log_group && length(var.audit_log_configuration) > 0 ? 1 : 0

  name              = var.cloudwatch_log_group_use_name_prefix ? null : local.log_group_name
  name_prefix       = var.cloudwatch_log_group_use_name_prefix ? "${local.log_group_name}-" : null
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id
  log_group_class   = var.cloudwatch_log_group_class

  tags = merge(
    var.tags,
    var.cloudwatch_log_group_tags,
    { Name = local.log_group_name }
  )
}

################################################################################
# Security Group
# Ref: https://docs.aws.amazon.com/fsx/latest/WindowsGuide/limit-access-security-groups.html
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
