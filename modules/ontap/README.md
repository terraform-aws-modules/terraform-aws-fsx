# AWS FSx for NetApp ONTAP Terraform module

Terraform module which creates AWS FSx for NetApp ONTAP resources.

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-fsx/tree/master/examples) directory for working examples to reference:

```hcl
module "fsx_ontap" {
source = "terraform-aws-modules/fsx/aws//modules/ontap"

  name = "example-ontap"

  # File system
  automatic_backup_retention_days   = 7
  daily_automatic_backup_start_time = "05:00"
  deployment_type                   = "MULTI_AZ_1"

  disk_iops_configuration = {
    iops = 3072
    mode = "USER_PROVISIONED"
  }

  fsx_admin_password            = "avoidPlaintextPasswords1"
  preferred_subnet_id           = "subnet-abcde012"
  route_table_ids               = ["rt-12322456", "rt-43433343"]
  storage_capacity              = 1024
  subnet_ids                    = ["subnet-abcde012", "subnet-bcde012a"]
  throughput_capacity           = 128
  weekly_maintenance_start_time = "1:06:00"

  # Storage Virtual Machine(s)
  storage_virtual_machines = {
    ex-basic = {
      name = "basic"

      volumes = {
        ex-basic = {
          name                       = "basic"
          junction_path              = "/test"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true
        }
      }
    }
    ex-other = {
      name                       = "one"
      root_volume_security_style = "NTFS"
      svm_admin_password         = "avoid-plaintext-passwords1"

      volumes = {
        ex-other = {
          name                       = "other"
          junction_path              = "/test"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          tiering_policy = {
            name           = "AUTO"
            cooling_period = 31
          }
        }
        ex-snaplock = {
          name                       = "snaplock"
          junction_path              = "/snaplock_audit_log"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          bypass_snaplock_enterprise_retention = true
          snaplock_configuration = {
            audit_log_volume           = true
            privileged_delete          = "PERMANENTLY_DISABLED"
            snaplock_type              = "ENTERPRISE"
            volume_append_mode_enabled = false

            autocommit_period = {
              type  = "DAYS"
              value = 14
            }

            retention_period = {
              default_retention = {
                type  = "DAYS"
                value = 30
              }

              maximum_retention = {
                type  = "MONTHS"
                value = 9
              }

              minimum_retention = {
                type  = "HOURS"
                value = 24
              }
            }
          }
        }
      }
    }
    ex-active-directory = {
      active_directory_configuration = {
        netbios_name = "mysvm"
        self_managed_active_directory_configuration = {
          dns_ips     = ["10.0.0.111", "10.0.0.222"]
          domain_name = "corp.example.com"
          password    = "avoid-plaintext-passwords"
          username    = "Admin"
        }
      }

      volumes = {
        ex-snaplock-ent = {
          name                       = "snaplock_ent"
          junction_path              = "/log"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          bypass_snaplock_enterprise_retention = true
          snaplock_configuration = {
            snaplock_type = "ENTERPRISE"
          }
        }
      }
    }
  }

  # Security group
  security_group_ingress_rules = {
    in = {
      cidr_ipv4   = ["10.0.0.0/16"]
      description = "Allow all traffic from the VPC"
      from_port   = 0
      to_port     = 0
      ip_protocol = "tcp"
    }
  }
  security_group_egress_rules = {
    out = {
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all traffic"
      ip_protocol = "-1"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-fsx/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [FSx for Lustre](https://github.com/terraform-aws-modules/terraform-aws-fsx/tree/master/examples/lustre)
- [FSx for NetApp ONTAP](https://github.com/terraform-aws-modules/terraform-aws-fsx/tree/master/examples/ontap)
- [FSx for OpenZFS](https://github.com/terraform-aws-modules/terraform-aws-fsx/tree/master/examples/openzfs)
- [FSx for Windows File Server](https://github.com/terraform-aws-modules/terraform-aws-fsx/tree/master/examples/windows)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.100 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_fsx_ontap_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_file_system) | resource |
| [aws_fsx_ontap_storage_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_storage_virtual_machine) | resource |
| [aws_fsx_ontap_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_volume) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatic_backup_retention_days"></a> [automatic\_backup\_retention\_days](#input\_automatic\_backup\_retention\_days) | The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days | `number` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_daily_automatic_backup_start_time"></a> [daily\_automatic\_backup\_start\_time](#input\_daily\_automatic\_backup\_start\_time) | A recurring daily time, in the format `HH:MM`. HH is the zero-padded hour of the day (0-23), and MM is the zero-padded minute of the hour. For example, `05:00` specifies 5 AM daily. Requires `automatic_backup_retention_days` to be set | `string` | `null` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The filesystem deployment type. One of: `MULTI_AZ_1` or `SINGLE_AZ_1` | `string` | `"MULTI_AZ_1"` | no |
| <a name="input_disk_iops_configuration"></a> [disk\_iops\_configuration](#input\_disk\_iops\_configuration) | The SSD IOPS configuration for the Amazon FSx for NetApp ONTAP file system | `map(string)` | `{}` | no |
| <a name="input_endpoint_ip_address_range"></a> [endpoint\_ip\_address\_range](#input\_endpoint\_ip\_address\_range) | Specifies the IP address range in which the endpoints to access your file system will be created. By default, Amazon FSx selects an unused IP address range for you from the 198.19.* range | `string` | `null` | no |
| <a name="input_fsx_admin_password"></a> [fsx\_admin\_password](#input\_fsx\_admin\_password) | The ONTAP administrative password for the fsxadmin user that you can use to administer your file system using the ONTAP CLI and REST API | `string` | `null` | no |
| <a name="input_ha_pairs"></a> [ha\_pairs](#input\_ha\_pairs) | The number of ha\_pairs to deploy for the file system. Valid values are 1 through 6. Recommend only using this parameter for 2 or more ha pairs | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the file system | `string` | `""` | no |
| <a name="input_preferred_subnet_id"></a> [preferred\_subnet\_id](#input\_preferred\_subnet\_id) | The ID for a subnet. A subnet is a range of IP addresses in your virtual private cloud (VPC) | `string` | `""` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | Specifies the VPC route tables in which your file system's endpoints will be created. You should specify all VPC route tables associated with the subnets in which your clients are located. By default, Amazon FSx selects your VPC's default route table | `list(string)` | `[]` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Security group egress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Security group ingress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | The storage capacity (GiB) of the file system | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The filesystem storage type. defaults to `SSD` | `string` | `null` | no |
| <a name="input_storage_virtual_machines"></a> [storage\_virtual\_machines](#input\_storage\_virtual\_machines) | A map of ONTAP storage virtual machine definitions to create | `any` | `{}` | no |
| <a name="input_storage_virtual_machines_timeouts"></a> [storage\_virtual\_machines\_timeouts](#input\_storage\_virtual\_machines\_timeouts) | Create, update, and delete timeout configurations for the storage virtual machines | `map(string)` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of IDs for the subnets that the file system will be accessible from | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_throughput_capacity"></a> [throughput\_capacity](#input\_throughput\_capacity) | Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, `2048`, and `4096`. Either `throughput_capacity` or `throughput_capacity_per_ha_pair` must be specified | `number` | `null` | no |
| <a name="input_throughput_capacity_per_ha_pair"></a> [throughput\_capacity\_per\_ha\_pair](#input\_throughput\_capacity\_per\_ha\_pair) | Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `3072`, `6144`. This parameter should only be used when specifying the `ha_pairs` parameter. Either `throughput_capacity` or `throughput_capacity_per_ha_pair` must be specified | `number` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configurations for the file system | `map(string)` | `{}` | no |
| <a name="input_volumes_timeouts"></a> [volumes\_timeouts](#input\_volumes\_timeouts) | Create, update, and delete timeout configurations for the volumes | `map(string)` | `{}` | no |
| <a name="input_weekly_maintenance_start_time"></a> [weekly\_maintenance\_start\_time](#input\_weekly\_maintenance\_start\_time) | The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_system_arn"></a> [file\_system\_arn](#output\_file\_system\_arn) | Amazon Resource Name of the file system |
| <a name="output_file_system_dns_name"></a> [file\_system\_dns\_name](#output\_file\_system\_dns\_name) | DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com` |
| <a name="output_file_system_endpoints"></a> [file\_system\_endpoints](#output\_file\_system\_endpoints) | The endpoints that are used to access data or to manage the file system using the NetApp ONTAP CLI, REST API, or NetApp SnapMirror |
| <a name="output_file_system_id"></a> [file\_system\_id](#output\_file\_system\_id) | Identifier of the file system, e.g., `fs-12345678` |
| <a name="output_file_system_network_interface_ids"></a> [file\_system\_network\_interface\_ids](#output\_file\_system\_network\_interface\_ids) | Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_storage_virtual_machines"></a> [storage\_virtual\_machines](#output\_storage\_virtual\_machines) | A map of ONTAP storage virtual machines created and their attributes |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | A map of ONTAP volumes created and their attributes |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-fsx/blob/master/LICENSE).
