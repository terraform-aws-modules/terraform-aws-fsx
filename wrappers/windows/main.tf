module "wrapper" {
  source = "../../modules/windows"

  for_each = var.items

  active_directory_id = try(each.value.active_directory_id, var.defaults.active_directory_id, null)
  aliases             = try(each.value.aliases, var.defaults.aliases, [])
  audit_log_configuration = try(each.value.audit_log_configuration, var.defaults.audit_log_configuration, {
    file_access_audit_log_level       = "FAILURE_ONLY"
    file_share_access_audit_log_level = "FAILURE_ONLY"
  })
  automatic_backup_retention_days        = try(each.value.automatic_backup_retention_days, var.defaults.automatic_backup_retention_days, null)
  backup_id                              = try(each.value.backup_id, var.defaults.backup_id, null)
  cloudwatch_log_group_class             = try(each.value.cloudwatch_log_group_class, var.defaults.cloudwatch_log_group_class, null)
  cloudwatch_log_group_kms_key_id        = try(each.value.cloudwatch_log_group_kms_key_id, var.defaults.cloudwatch_log_group_kms_key_id, null)
  cloudwatch_log_group_name              = try(each.value.cloudwatch_log_group_name, var.defaults.cloudwatch_log_group_name, null)
  cloudwatch_log_group_retention_in_days = try(each.value.cloudwatch_log_group_retention_in_days, var.defaults.cloudwatch_log_group_retention_in_days, 90)
  cloudwatch_log_group_skip_destroy      = try(each.value.cloudwatch_log_group_skip_destroy, var.defaults.cloudwatch_log_group_skip_destroy, null)
  cloudwatch_log_group_tags              = try(each.value.cloudwatch_log_group_tags, var.defaults.cloudwatch_log_group_tags, {})
  cloudwatch_log_group_use_name_prefix   = try(each.value.cloudwatch_log_group_use_name_prefix, var.defaults.cloudwatch_log_group_use_name_prefix, true)
  copy_tags_to_backups                   = try(each.value.copy_tags_to_backups, var.defaults.copy_tags_to_backups, null)
  create                                 = try(each.value.create, var.defaults.create, true)
  create_cloudwatch_log_group            = try(each.value.create_cloudwatch_log_group, var.defaults.create_cloudwatch_log_group, true)
  create_security_group                  = try(each.value.create_security_group, var.defaults.create_security_group, true)
  daily_automatic_backup_start_time      = try(each.value.daily_automatic_backup_start_time, var.defaults.daily_automatic_backup_start_time, null)
  deployment_type                        = try(each.value.deployment_type, var.defaults.deployment_type, null)
  disk_iops_configuration                = try(each.value.disk_iops_configuration, var.defaults.disk_iops_configuration, {})
  kms_key_id                             = try(each.value.kms_key_id, var.defaults.kms_key_id, null)
  name                                   = try(each.value.name, var.defaults.name, "")
  preferred_subnet_id                    = try(each.value.preferred_subnet_id, var.defaults.preferred_subnet_id, null)
  security_group_description             = try(each.value.security_group_description, var.defaults.security_group_description, null)
  security_group_egress_rules = try(each.value.security_group_egress_rules, var.defaults.security_group_egress_rules, {
    ipv4 = {
      description = "Allow all outbound traffic by default"
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
    ipv6 = {
      description = "Allow all outbound traffic by default"
      ip_protocol = "-1"
      cidr_ipv6   = "::/0"
    }
  })
  security_group_ids             = try(each.value.security_group_ids, var.defaults.security_group_ids, [])
  security_group_ingress_rules   = try(each.value.security_group_ingress_rules, var.defaults.security_group_ingress_rules, {})
  security_group_name            = try(each.value.security_group_name, var.defaults.security_group_name, null)
  security_group_tags            = try(each.value.security_group_tags, var.defaults.security_group_tags, {})
  security_group_use_name_prefix = try(each.value.security_group_use_name_prefix, var.defaults.security_group_use_name_prefix, true)
  self_managed_active_directory  = try(each.value.self_managed_active_directory, var.defaults.self_managed_active_directory, {})
  skip_final_backup              = try(each.value.skip_final_backup, var.defaults.skip_final_backup, null)
  storage_capacity               = try(each.value.storage_capacity, var.defaults.storage_capacity, null)
  storage_type                   = try(each.value.storage_type, var.defaults.storage_type, null)
  subnet_ids                     = try(each.value.subnet_ids, var.defaults.subnet_ids, [])
  tags                           = try(each.value.tags, var.defaults.tags, {})
  throughput_capacity            = try(each.value.throughput_capacity, var.defaults.throughput_capacity, null)
  timeouts                       = try(each.value.timeouts, var.defaults.timeouts, {})
  weekly_maintenance_start_time  = try(each.value.weekly_maintenance_start_time, var.defaults.weekly_maintenance_start_time, null)
}
