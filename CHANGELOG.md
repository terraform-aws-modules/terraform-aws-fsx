# Changelog

All notable changes to this project will be documented in this file.

## [1.3.0](https://github.com/terraform-aws-modules/terraform-aws-fsx/compare/v1.2.0...v1.3.0) (2025-06-18)


### Features

* Support FSX Lustre Intelligent Tiering ([#7](https://github.com/terraform-aws-modules/terraform-aws-fsx/issues/7)) ([a3823ce](https://github.com/terraform-aws-modules/terraform-aws-fsx/commit/a3823ce609b5fe061647a9efec3a995f3fdcadb7))

## [1.2.0](https://github.com/terraform-aws-modules/terraform-aws-fsx/compare/v1.1.1...v1.2.0) (2024-12-23)


### Features

* Support `aws_fsx_lustre_file_system.efa_enabled` ([#6](https://github.com/terraform-aws-modules/terraform-aws-fsx/issues/6)) ([e172a5b](https://github.com/terraform-aws-modules/terraform-aws-fsx/commit/e172a5b820cb099d2ca0c17657b3d002f80d2358))

## [1.1.1](https://github.com/terraform-aws-modules/terraform-aws-fsx/compare/v1.1.0...v1.1.1) (2024-10-11)


### Bug Fixes

* Update CI workflow versions to latest ([#5](https://github.com/terraform-aws-modules/terraform-aws-fsx/issues/5)) ([c49b355](https://github.com/terraform-aws-modules/terraform-aws-fsx/commit/c49b355bdf1ae627691c115697690a8fa99fd175))

## [1.1.0](https://github.com/terraform-aws-modules/terraform-aws-fsx/compare/v1.0.2...v1.1.0) (2024-06-14)


### Features

* Add `metadata_configuration` to FSx Lustre, `aggregate_configuration` to FSx Ontap, and `file_system_endpoint_ip_address` attribute to Openzfs ([#4](https://github.com/terraform-aws-modules/terraform-aws-fsx/issues/4)) ([432eeb2](https://github.com/terraform-aws-modules/terraform-aws-fsx/commit/432eeb288a5fb1d58c1de7d5236c7a2cd91c1952))

## [1.0.2](https://github.com/terraform-aws-modules/terraform-aws-fsx/compare/v1.0.1...v1.0.2) (2024-06-11)


### Bug Fixes

* Correct mis-spelled output `volumes` on Ontap sub-module ([#3](https://github.com/terraform-aws-modules/terraform-aws-fsx/issues/3)) ([4c15bdd](https://github.com/terraform-aws-modules/terraform-aws-fsx/commit/4c15bdd4f1f6952a97903e17cc6f2098ea0c32f6))

## [1.0.1](https://github.com/terraform-aws-modules/terraform-aws-fsx/compare/v1.0.0...v1.0.1) (2024-05-14)


### Bug Fixes

* Output value for file_system_root_volume_id ([#2](https://github.com/terraform-aws-modules/terraform-aws-fsx/issues/2)) ([9d60a19](https://github.com/terraform-aws-modules/terraform-aws-fsx/commit/9d60a193ebc10db609dcb8bbb7bfe93d85d36345))
