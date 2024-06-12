# Complete AWS FSx for OpenZFS Example

Configuration in this directory creates:

- FSx for OpenZFS storage system

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.53 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.53 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fsx_openzfs"></a> [fsx\_openzfs](#module\_fsx\_openzfs) | ../../modules/openzfs | n/a |
| <a name="module_fsx_openzfs_disabled"></a> [fsx\_openzfs\_disabled](#module\_fsx\_openzfs\_disabled) | ../../modules/openzfs | n/a |
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

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-fsx/blob/master/LICENSE).
