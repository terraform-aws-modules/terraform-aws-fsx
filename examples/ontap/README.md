# Complete AWS FSx for NetApp ONTAP Example

Configuration in this directory creates:

- FSx for NetApp ONTAP storage system

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.82 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.82 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fsx_ontap"></a> [fsx\_ontap](#module\_fsx\_ontap) | ../../modules/ontap | n/a |
| <a name="module_fsx_ontap_disabled"></a> [fsx\_ontap\_disabled](#module\_fsx\_ontap\_disabled) | ../../modules/ontap | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_directory_service_directory.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_directory) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

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

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-fsx/blob/master/LICENSE).
