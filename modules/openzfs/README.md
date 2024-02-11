# AWS FSx for OpenZFS Terraform module

Terraform module which creates AWS FSx for OpenZFS resources.

## Usage

See [`examples`](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples) directory for working examples to reference:

```hcl
module "fsx_openzfs" {
  source = "clowdhaus/fsx/aws//modules/openzfs"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [FSx for Lustre](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples/lustre)
- [FSx for NetApp ONTAP](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples/ontap)
- [FSx for OpenZFS](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples/openzfs)
- [FSx for Windows File Server](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples/windows)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.34 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_fsx_openzfs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_openzfs_file_system) | resource |
| [aws_fsx_openzfs_snapshot.child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_openzfs_snapshot) | resource |
| [aws_fsx_openzfs_snapshot.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_openzfs_snapshot) | resource |
| [aws_fsx_openzfs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_openzfs_volume) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatic_backup_retention_days"></a> [automatic\_backup\_retention\_days](#input\_automatic\_backup\_retention\_days) | The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days. only valid for `PERSISTENT_1` and `PERSISTENT_2` deployment\_type | `number` | `null` | no |
| <a name="input_backup_id"></a> [backup\_id](#input\_backup\_id) | The ID of the source backup to create the filesystem from | `string` | `null` | no |
| <a name="input_copy_tags_to_backups"></a> [copy\_tags\_to\_backups](#input\_copy\_tags\_to\_backups) | A boolean flag indicating whether tags for the file system should be copied to backups | `bool` | `false` | no |
| <a name="input_copy_tags_to_volumes"></a> [copy\_tags\_to\_volumes](#input\_copy\_tags\_to\_volumes) | A boolean flag indicating whether tags for the file system should be copied to snapshots. The default value is `false` | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_create_snapshot"></a> [create\_snapshot](#input\_create\_snapshot) | Determines if a root volume snapshot is created | `bool` | `false` | no |
| <a name="input_daily_automatic_backup_start_time"></a> [daily\_automatic\_backup\_start\_time](#input\_daily\_automatic\_backup\_start\_time) | The preferred time to take daily automatic backups, in the UTC time zone. | `string` | `null` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The filesystem deployment type. Only `SINGLE_AZ_1` is supported | `string` | `null` | no |
| <a name="input_disk_iops_configuration"></a> [disk\_iops\_configuration](#input\_disk\_iops\_configuration) | The SSD IOPS configuration for the Amazon FSx for NetApp ONTAP file system | `map(string)` | `{}` | no |
| <a name="input_endpoint_ip_address_range"></a> [endpoint\_ip\_address\_range](#input\_endpoint\_ip\_address\_range) | (Multi-AZ only) Specifies the IP address range in which the endpoints to access your file system will be created | `string` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the file system | `string` | `""` | no |
| <a name="input_preferred_subnet_id"></a> [preferred\_subnet\_id](#input\_preferred\_subnet\_id) | (Multi-AZ only) Required when deployment\_type is set to `MULTI_AZ_1`. This specifies the subnet in which you want the preferred file server to be located | `string` | `null` | no |
| <a name="input_root_volume_configuration"></a> [root\_volume\_configuration](#input\_root\_volume\_configuration) | The configuration for the root volume of the file system. All other volumes are children or the root volume | `any` | `{}` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | (Multi-AZ only) Specifies the route tables in which Amazon FSx creates the rules for routing traffic to the correct file server. You should specify all virtual private cloud (VPC) route tables associated with the subnets in which your clients are located | `list(string)` | `[]` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Security group egress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Security group ingress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_skip_final_backup"></a> [skip\_final\_backup](#input\_skip\_final\_backup) | When enabled, will skip the default final backup taken when the file system is deleted | `bool` | `null` | no |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input\_snapshot\_name) | The name of the root volume snapshot | `string` | `null` | no |
| <a name="input_snapshot_timeouts"></a> [snapshot\_timeouts](#input\_snapshot\_timeouts) | Create, update, and delete timeout configurations for the snapshots | `map(string)` | `{}` | no |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | The storage capacity (GiB) of the file system | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The filesystem storage type. Either `SSD` or `HDD`, defaults to `SSD` | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of IDs for the subnets that the file system will be accessible from | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_throughput_capacity"></a> [throughput\_capacity](#input\_throughput\_capacity) | Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048` | `number` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configurations for the file system | `map(string)` | `{}` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A map of OpenZFS volume definitions to create | `any` | `{}` | no |
| <a name="input_volumes_timeouts"></a> [volumes\_timeouts](#input\_volumes\_timeouts) | Create, update, and delete timeout configurations for the volumes | `map(string)` | `{}` | no |
| <a name="input_weekly_maintenance_start_time"></a> [weekly\_maintenance\_start\_time](#input\_weekly\_maintenance\_start\_time) | The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_child_volumes_snapshots"></a> [child\_volumes\_snapshots](#output\_child\_volumes\_snapshots) | A map of OpenZFS child volumes and their snapshots |
| <a name="output_file_system_arn"></a> [file\_system\_arn](#output\_file\_system\_arn) | Amazon Resource Name of the file system |
| <a name="output_file_system_dns_name"></a> [file\_system\_dns\_name](#output\_file\_system\_dns\_name) | DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com` |
| <a name="output_file_system_id"></a> [file\_system\_id](#output\_file\_system\_id) | Identifier of the file system, e.g., `fs-12345678` |
| <a name="output_file_system_network_interface_ids"></a> [file\_system\_network\_interface\_ids](#output\_file\_system\_network\_interface\_ids) | Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface |
| <a name="output_file_system_root_volume_id"></a> [file\_system\_root\_volume\_id](#output\_file\_system\_root\_volume\_id) | Identifier of the root volume, e.g., `fsvol-12345678` |
| <a name="output_root_volume_snapshot_arn"></a> [root\_volume\_snapshot\_arn](#output\_root\_volume\_snapshot\_arn) | Amazon Resource Name (ARN) of the root volume snapshot |
| <a name="output_root_volume_snapshot_id"></a> [root\_volume\_snapshot\_id](#output\_root\_volume\_snapshot\_id) | ID of the root volume snapshot |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | A map of OpenZFS volumes created and their attributes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-fsx/blob/main/LICENSE).
