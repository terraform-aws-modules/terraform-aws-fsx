# Complete AWS FSx for Lustre Example

Configuration in this directory creates:

- FSx for Lustre file system with persistent1 storage
- FSx for Lustre file system with persistent2 storage

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fsx_lustre_disabled"></a> [fsx\_lustre\_disabled](#module\_fsx\_lustre\_disabled) | ../../modules/lustre | n/a |
| <a name="module_fsx_lustre_persistent_1"></a> [fsx\_lustre\_persistent\_1](#module\_fsx\_lustre\_persistent\_1) | ../../modules/lustre | n/a |
| <a name="module_fsx_lustre_persistent_2"></a> [fsx\_lustre\_persistent\_2](#module\_fsx\_lustre\_persistent\_2) | ../../modules/lustre | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_persistent_1_backup_arn"></a> [persistent\_1\_backup\_arn](#output\_persistent\_1\_backup\_arn) | Amazon Resource Name of the backup |
| <a name="output_persistent_1_backup_id"></a> [persistent\_1\_backup\_id](#output\_persistent\_1\_backup\_id) | Identifier of the backup |
| <a name="output_persistent_1_cloudwatch_log_group_arn"></a> [persistent\_1\_cloudwatch\_log\_group\_arn](#output\_persistent\_1\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_persistent_1_cloudwatch_log_group_name"></a> [persistent\_1\_cloudwatch\_log\_group\_name](#output\_persistent\_1\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_persistent_1_data_repository_associations"></a> [persistent\_1\_data\_repository\_associations](#output\_persistent\_1\_data\_repository\_associations) | Data repository associations created and their attributes |
| <a name="output_persistent_1_file_cache_arn"></a> [persistent\_1\_file\_cache\_arn](#output\_persistent\_1\_file\_cache\_arn) | Amazon Resource Name of the file cache |
| <a name="output_persistent_1_file_cache_dns_name"></a> [persistent\_1\_file\_cache\_dns\_name](#output\_persistent\_1\_file\_cache\_dns\_name) | The Domain Name System (DNS) name for the cache |
| <a name="output_persistent_1_file_cache_id"></a> [persistent\_1\_file\_cache\_id](#output\_persistent\_1\_file\_cache\_id) | Identifier of the file cache |
| <a name="output_persistent_1_file_system_arn"></a> [persistent\_1\_file\_system\_arn](#output\_persistent\_1\_file\_system\_arn) | Amazon Resource Name of the file system |
| <a name="output_persistent_1_file_system_dns_name"></a> [persistent\_1\_file\_system\_dns\_name](#output\_persistent\_1\_file\_system\_dns\_name) | DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com` |
| <a name="output_persistent_1_file_system_id"></a> [persistent\_1\_file\_system\_id](#output\_persistent\_1\_file\_system\_id) | Identifier of the file system, e.g., `fs-12345678` |
| <a name="output_persistent_1_file_system_mount_name"></a> [persistent\_1\_file\_system\_mount\_name](#output\_persistent\_1\_file\_system\_mount\_name) | The value to be used when mounting the filesystem |
| <a name="output_persistent_1_file_system_network_interface_ids"></a> [persistent\_1\_file\_system\_network\_interface\_ids](#output\_persistent\_1\_file\_system\_network\_interface\_ids) | Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface |
| <a name="output_persistent_1_security_group_arn"></a> [persistent\_1\_security\_group\_arn](#output\_persistent\_1\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_persistent_1_security_group_id"></a> [persistent\_1\_security\_group\_id](#output\_persistent\_1\_security\_group\_id) | ID of the security group |
| <a name="output_persistent_2_backup_arn"></a> [persistent\_2\_backup\_arn](#output\_persistent\_2\_backup\_arn) | Amazon Resource Name of the backup |
| <a name="output_persistent_2_backup_id"></a> [persistent\_2\_backup\_id](#output\_persistent\_2\_backup\_id) | Identifier of the backup |
| <a name="output_persistent_2_cloudwatch_log_group_arn"></a> [persistent\_2\_cloudwatch\_log\_group\_arn](#output\_persistent\_2\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_persistent_2_cloudwatch_log_group_name"></a> [persistent\_2\_cloudwatch\_log\_group\_name](#output\_persistent\_2\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_persistent_2_data_repository_associations"></a> [persistent\_2\_data\_repository\_associations](#output\_persistent\_2\_data\_repository\_associations) | Data repository associations created and their attributes |
| <a name="output_persistent_2_file_cache_arn"></a> [persistent\_2\_file\_cache\_arn](#output\_persistent\_2\_file\_cache\_arn) | Amazon Resource Name of the file cache |
| <a name="output_persistent_2_file_cache_dns_name"></a> [persistent\_2\_file\_cache\_dns\_name](#output\_persistent\_2\_file\_cache\_dns\_name) | The Domain Name System (DNS) name for the cache |
| <a name="output_persistent_2_file_cache_id"></a> [persistent\_2\_file\_cache\_id](#output\_persistent\_2\_file\_cache\_id) | Identifier of the file cache |
| <a name="output_persistent_2_file_system_arn"></a> [persistent\_2\_file\_system\_arn](#output\_persistent\_2\_file\_system\_arn) | Amazon Resource Name of the file system |
| <a name="output_persistent_2_file_system_dns_name"></a> [persistent\_2\_file\_system\_dns\_name](#output\_persistent\_2\_file\_system\_dns\_name) | DNS name for the file system, e.g., `fs-12345678.fsx.us-west-2.amazonaws.com` |
| <a name="output_persistent_2_file_system_id"></a> [persistent\_2\_file\_system\_id](#output\_persistent\_2\_file\_system\_id) | Identifier of the file system, e.g., `fs-12345678` |
| <a name="output_persistent_2_file_system_mount_name"></a> [persistent\_2\_file\_system\_mount\_name](#output\_persistent\_2\_file\_system\_mount\_name) | The value to be used when mounting the filesystem |
| <a name="output_persistent_2_file_system_network_interface_ids"></a> [persistent\_2\_file\_system\_network\_interface\_ids](#output\_persistent\_2\_file\_system\_network\_interface\_ids) | Set of Elastic Network Interface identifiers from which the file system is accessible. As explained in the [documentation](https://docs.aws.amazon.com/fsx/latest/LustreGuide/mounting-on-premises.html), the first network interface returned is the primary network interface |
| <a name="output_persistent_2_security_group_arn"></a> [persistent\_2\_security\_group\_arn](#output\_persistent\_2\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_persistent_2_security_group_id"></a> [persistent\_2\_security\_group\_id](#output\_persistent\_2\_security\_group\_id) | ID of the security group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-fsx/blob/main/LICENSE).
