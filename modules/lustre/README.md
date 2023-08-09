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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_fsx_backup.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_backup) | resource |
| [aws_fsx_data_repository_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_data_repository_association) | resource |
| [aws_fsx_file_cache.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_file_cache) | resource |
| [aws_fsx_lustre_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_lustre_file_system) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_import_policy"></a> [auto\_import\_policy](#input\_auto\_import\_policy) | How Amazon FSx keeps your file and directory listings up to date as you add or modify objects in your linked S3 bucket | `string` | `null` | no |
| <a name="input_automatic_backup_retention_days"></a> [automatic\_backup\_retention\_days](#input\_automatic\_backup\_retention\_days) | The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days. only valid for `PERSISTENT_1` and `PERSISTENT_2` deployment\_type | `number` | `null` | no |
| <a name="input_backup_id"></a> [backup\_id](#input\_backup\_id) | The ID of the source backup to create the filesystem from | `string` | `null` | no |
| <a name="input_backup_tags"></a> [backup\_tags](#input\_backup\_tags) | A map of additional tags to assign to the backup | `map(string)` | `{}` | no |
| <a name="input_backup_timeouts"></a> [backup\_timeouts](#input\_backup\_timeouts) | Create and delete timeout configurations for the backup | `map(string)` | `{}` | no |
| <a name="input_copy_tags_to_backups"></a> [copy\_tags\_to\_backups](#input\_copy\_tags\_to\_backups) | A boolean flag indicating whether tags for the file system should be copied to backups | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_backup"></a> [create\_backup](#input\_create\_backup) | Whether to create a backup of the file system | `bool` | `false` | no |
| <a name="input_create_file_cache"></a> [create\_file\_cache](#input\_create\_file\_cache) | Determines whether a file cache is created | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_daily_automatic_backup_start_time"></a> [daily\_automatic\_backup\_start\_time](#input\_daily\_automatic\_backup\_start\_time) | The preferred time to take daily automatic backups, in the UTC time zone. | `string` | `null` | no |
| <a name="input_data_compression_type"></a> [data\_compression\_type](#input\_data\_compression\_type) | Sets the data compression configuration for the file system. Valid values are `LZ4` and `NONE`. Default value is `NONE` | `string` | `null` | no |
| <a name="input_data_repository_associations"></a> [data\_repository\_associations](#input\_data\_repository\_associations) | A map of data repository associations to create | `any` | `{}` | no |
| <a name="input_data_repository_associations_timeouts"></a> [data\_repository\_associations\_timeouts](#input\_data\_repository\_associations\_timeouts) | Create, update, and delete timeout configurations for the data repository associations | `map(string)` | `{}` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The filesystem deployment type. One of: `SCRATCH_1`, `SCRATCH_2`, `PERSISTENT_1`, `PERSISTENT_2` | `string` | `null` | no |
| <a name="input_drive_cache_type"></a> [drive\_cache\_type](#input\_drive\_cache\_type) | The type of drive cache used by `PERSISTENT_1` filesystems that are provisioned with `HDD` `storage_type` | `string` | `null` | no |
| <a name="input_export_path"></a> [export\_path](#input\_export\_path) | S3 URI (with optional prefix) where the root of your Amazon FSx file system is exported | `string` | `null` | no |
| <a name="input_file_cache_copy_tags_to_data_repository_associations"></a> [file\_cache\_copy\_tags\_to\_data\_repository\_associations](#input\_file\_cache\_copy\_tags\_to\_data\_repository\_associations) | A boolean flag indicating whether tags for the cache should be copied to data repository associations. This value defaults to `false` | `bool` | `null` | no |
| <a name="input_file_cache_kms_key_id"></a> [file\_cache\_kms\_key\_id](#input\_file\_cache\_kms\_key\_id) | Specifies the ID of the AWS Key Management Service (AWS KMS) key to use for encrypting data on an Amazon File Cache | `string` | `null` | no |
| <a name="input_file_cache_lustre_configuration"></a> [file\_cache\_lustre\_configuration](#input\_file\_cache\_lustre\_configuration) | The configuration object for Amazon FSx for Lustre | `any` | `{}` | no |
| <a name="input_file_cache_storage_capacity"></a> [file\_cache\_storage\_capacity](#input\_file\_cache\_storage\_capacity) | The storage capacity of the cache in gibibytes (GiB). Valid values are 1200 GiB, 2400 GiB, and increments of 2400 GiB | `number` | `null` | no |
| <a name="input_file_cache_type_version"></a> [file\_cache\_type\_version](#input\_file\_cache\_type\_version) | The version for the type of cache that you're creating | `string` | `"2.12"` | no |
| <a name="input_file_system_type_version"></a> [file\_system\_type\_version](#input\_file\_system\_type\_version) | Sets the Lustre version for the file system that you're creating | `string` | `null` | no |
| <a name="input_import_path"></a> [import\_path](#input\_import\_path) | S3 URI (with optional prefix) that you're using as the data repository for your FSx for Lustre file system | `string` | `null` | no |
| <a name="input_imported_file_chunk_size"></a> [imported\_file\_chunk\_size](#input\_imported\_file\_chunk\_size) | For files imported from a data repository, this value determines the stripe count and maximum amount of data per file (in MiB) stored on a single physical disk | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key | `string` | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | The configuration object for Amazon FSx for Lustre file systems used in the CreateFileSystem and CreateFileSystemFromBackup operations. | `map(string)` | `{}` | no |
| <a name="input_per_unit_storage_throughput"></a> [per\_unit\_storage\_throughput](#input\_per\_unit\_storage\_throughput) | Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the `PERSISTENT_1` and `PERSISTENT_2` deployment\_type | `number` | `null` | no |
| <a name="input_root_squash_configuration"></a> [root\_squash\_configuration](#input\_root\_squash\_configuration) | The Lustre root squash configuration used when creating an Amazon FSx for Lustre file system. When enabled, root squash restricts root-level access from clients that try to access your file system as a root user | `any` | `{}` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Security group egress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Security group ingress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | The storage capacity (GiB) of the file system | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The filesystem storage type. Either `SSD` or `HDD`, defaults to `SSD` | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of IDs for the subnets that the file system will be accessible from | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configurations for the file system | `map(string)` | `{}` | no |
| <a name="input_weekly_maintenance_start_time"></a> [weekly\_maintenance\_start\_time](#input\_weekly\_maintenance\_start\_time) | The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_arn"></a> [backup\_arn](#output\_backup\_arn) | Amazon Resource Name of the backup |
| <a name="output_backup_id"></a> [backup\_id](#output\_backup\_id) | Identifier of the backup |
| <a name="output_data_repository_associations"></a> [data\_repository\_associations](#output\_data\_repository\_associations) | Data repository associations created and their attributes |
| <a name="output_file_cache_arn"></a> [file\_cache\_arn](#output\_file\_cache\_arn) | Amazon Resource Name of the file cache |
| <a name="output_file_cache_dns_name"></a> [file\_cache\_dns\_name](#output\_file\_cache\_dns\_name) | The Domain Name System (DNS) name for the cache |
| <a name="output_file_cache_id"></a> [file\_cache\_id](#output\_file\_cache\_id) | Identifier of the file cache |
| <a name="output_file_system_arn"></a> [file\_system\_arn](#output\_file\_system\_arn) | Amazon Resource Name of the file system |
| <a name="output_file_system_dns_name"></a> [file\_system\_dns\_name](#output\_file\_system\_dns\_name) | DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com` |
| <a name="output_file_system_id"></a> [file\_system\_id](#output\_file\_system\_id) | Identifier of the file system, e.g., `fs-12345678` |
| <a name="output_file_system_mount_name"></a> [file\_system\_mount\_name](#output\_file\_system\_mount\_name) | The value to be used when mounting the filesystem |
| <a name="output_file_system_network_interface_ids"></a> [file\_system\_network\_interface\_ids](#output\_file\_system\_network\_interface\_ids) | Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-fsx/blob/main/LICENSE).
