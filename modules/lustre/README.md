# AWS FSx Terraform module

Terraform module which creates AWS FSx resources.

## Usage

See [`examples`](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples) directory for working examples to reference:

```hcl
module "fsx" {
  source = "clowdhaus/fsx/aws"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/clowdhaus/terraform-aws-fsx/tree/main/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.45 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_fsx_lustre_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_lustre_file_system) | resource |
| [aws_fsx_ontap_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_file_system) | resource |
| [aws_fsx_ontap_storage_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_storage_virtual_machine) | resource |
| [aws_fsx_openzfs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_openzfs_file_system) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_import_policy"></a> [auto\_import\_policy](#input\_auto\_import\_policy) | How Amazon FSx keeps your file and directory listings up to date as you add or modify objects in your linked S3 bucket | `string` | `null` | no |
| <a name="input_automatic_backup_retention_days"></a> [automatic\_backup\_retention\_days](#input\_automatic\_backup\_retention\_days) | The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days. only valid for `PERSISTENT_1` and `PERSISTENT_2` deployment\_type | `number` | `null` | no |
| <a name="input_backup_id"></a> [backup\_id](#input\_backup\_id) | The ID of the source backup to create the filesystem from | `string` | `null` | no |
| <a name="input_copy_tags_to_backups"></a> [copy\_tags\_to\_backups](#input\_copy\_tags\_to\_backups) | A boolean flag indicating whether tags for the file system should be copied to backups | `bool` | `false` | no |
| <a name="input_copy_tags_to_volumes"></a> [copy\_tags\_to\_volumes](#input\_copy\_tags\_to\_volumes) | A boolean flag indicating whether tags for the file system should be copied to snapshots. The default value is `false` | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_lustre"></a> [create\_lustre](#input\_create\_lustre) | Determines whether a FSx for Lustre filesystem will be created | `bool` | `false` | no |
| <a name="input_create_ontap"></a> [create\_ontap](#input\_create\_ontap) | Determines whether a FSx ONTAP filesystem will be created | `bool` | `false` | no |
| <a name="input_create_openzfs"></a> [create\_openzfs](#input\_create\_openzfs) | Determines whether a FSx OpenZFS filesystem will be created | `bool` | `false` | no |
| <a name="input_daily_automatic_backup_start_time"></a> [daily\_automatic\_backup\_start\_time](#input\_daily\_automatic\_backup\_start\_time) | The preferred time to take daily automatic backups, in the UTC time zone. | `string` | `null` | no |
| <a name="input_data_compression_type"></a> [data\_compression\_type](#input\_data\_compression\_type) | Sets the data compression configuration for the file system. Valid values are `LZ4` and `NONE`. Default value is `NONE` | `string` | `null` | no |
| <a name="input_disk_iops_configuration"></a> [disk\_iops\_configuration](#input\_disk\_iops\_configuration) | The SSD IOPS configuration for the Amazon FSx for NetApp ONTAP file system | `map(string)` | `{}` | no |
| <a name="input_drive_cache_type"></a> [drive\_cache\_type](#input\_drive\_cache\_type) | The type of drive cache used by `PERSISTENT_1` filesystems that are provisioned with `HDD` `storage_type` | `string` | `null` | no |
| <a name="input_endpoint_ip_address_range"></a> [endpoint\_ip\_address\_range](#input\_endpoint\_ip\_address\_range) | Specifies the IP address range in which the endpoints to access your file system will be created. By default, Amazon FSx selects an unused IP address range for you from the 198.19.* range | `string` | `null` | no |
| <a name="input_export_path"></a> [export\_path](#input\_export\_path) | S3 URI (with optional prefix) where the root of your Amazon FSx file system is exported | `string` | `null` | no |
| <a name="input_file_system_type_version"></a> [file\_system\_type\_version](#input\_file\_system\_type\_version) | Sets the Lustre version for the file system that you're creating | `string` | `null` | no |
| <a name="input_fsx_admin_password"></a> [fsx\_admin\_password](#input\_fsx\_admin\_password) | The ONTAP administrative password for the fsxadmin user that you can use to administer your file system using the ONTAP CLI and REST API | `string` | `null` | no |
| <a name="input_import_path"></a> [import\_path](#input\_import\_path) | S3 URI (with optional prefix) that you're using as the data repository for your FSx for Lustre file system | `string` | `null` | no |
| <a name="input_imported_file_chunk_size"></a> [imported\_file\_chunk\_size](#input\_imported\_file\_chunk\_size) | For files imported from a data repository, this value determines the stripe count and maximum amount of data per file (in MiB) stored on a single physical disk | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key | `string` | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | The configuration object for Amazon FSx for Lustre file systems used in the CreateFileSystem and CreateFileSystemFromBackup operations. | `map(string)` | `{}` | no |
| <a name="input_lustre_deployment_type"></a> [lustre\_deployment\_type](#input\_lustre\_deployment\_type) | The filesystem deployment type. One of: `SCRATCH_1`, `SCRATCH_2`, `PERSISTENT_1`, `PERSISTENT_2` | `string` | `null` | no |
| <a name="input_ontap_deployment_type"></a> [ontap\_deployment\_type](#input\_ontap\_deployment\_type) | The filesystem deployment type. One of: `MULTI_AZ_1` or `SINGLE_AZ_1` | `string` | `null` | no |
| <a name="input_ontap_storage_virtual_machines"></a> [ontap\_storage\_virtual\_machines](#input\_ontap\_storage\_virtual\_machines) | A map of ONTAP storage virtual machine definitions to create | `any` | `{}` | no |
| <a name="input_ontap_throughput_capacity"></a> [ontap\_throughput\_capacity](#input\_ontap\_throughput\_capacity) | Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048` | `number` | `null` | no |
| <a name="input_openzfs_deployment_type"></a> [openzfs\_deployment\_type](#input\_openzfs\_deployment\_type) | The filesystem deployment type. Only `SINGLE_AZ_1` is supported | `string` | `null` | no |
| <a name="input_openzfs_throughput_capacity"></a> [openzfs\_throughput\_capacity](#input\_openzfs\_throughput\_capacity) | Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are `128`, `256`, `512`, `1024`, and `2048` | `number` | `null` | no |
| <a name="input_per_unit_storage_throughput"></a> [per\_unit\_storage\_throughput](#input\_per\_unit\_storage\_throughput) | Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the `PERSISTENT_1` and `PERSISTENT_2` deployment\_type | `number` | `null` | no |
| <a name="input_preferred_subnet_id"></a> [preferred\_subnet\_id](#input\_preferred\_subnet\_id) | The ID for a subnet. A subnet is a range of IP addresses in your virtual private cloud (VPC) | `string` | `""` | no |
| <a name="input_root_volume_configuration"></a> [root\_volume\_configuration](#input\_root\_volume\_configuration) | The configuration for the root volume of the file system. All other volumes are children or the root volume | `any` | `{}` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | Specifies the VPC route tables in which your file system's endpoints will be created. You should specify all VPC route tables associated with the subnets in which your clients are located. By default, Amazon FSx selects your VPC's default route table | `list(string)` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces | `list(string)` | `[]` | no |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | The storage capacity (GiB) of the file system | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The filesystem storage type. Either `SSD` or `HDD`, defaults to `SSD` | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of IDs for the subnets that the file system will be accessible from | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_weekly_maintenance_start_time"></a> [weekly\_maintenance\_start\_time](#input\_weekly\_maintenance\_start\_time) | The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_system_arn"></a> [file\_system\_arn](#output\_file\_system\_arn) | Amazon Resource Name of the file system |
| <a name="output_file_system_dns_name"></a> [file\_system\_dns\_name](#output\_file\_system\_dns\_name) | DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com` |
| <a name="output_file_system_endpoints"></a> [file\_system\_endpoints](#output\_file\_system\_endpoints) | he endpoints that are used to access data or to manage the file system using the NetApp ONTAP CLI, REST API, or NetApp SnapMirror |
| <a name="output_file_system_id"></a> [file\_system\_id](#output\_file\_system\_id) | Identifier of the file system, e.g., `fs-12345678` |
| <a name="output_file_system_mount_name"></a> [file\_system\_mount\_name](#output\_file\_system\_mount\_name) | The value to be used when mounting the filesystem |
| <a name="output_file_system_network_interface_ids"></a> [file\_system\_network\_interface\_ids](#output\_file\_system\_network\_interface\_ids) | Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface |
| <a name="output_file_system_root_volume_id"></a> [file\_system\_root\_volume\_id](#output\_file\_system\_root\_volume\_id) | Identifier of the root volume, e.g., `fsvol-12345678` |
| <a name="output_ontap_storage_virtual_machines"></a> [ontap\_storage\_virtual\_machines](#output\_ontap\_storage\_virtual\_machines) | A map of ONTAP storage virtual machines created and their attributes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-fsx/blob/main/LICENSE).
