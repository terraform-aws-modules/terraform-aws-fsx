provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "eu-west-1"
  name   = "ex-fsx-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/clowdhaus/terraform-aws-fsx"
  }
}

################################################################################
# FSx Module
################################################################################

module "fsx_lustre_persistent_1" {
  source = "../../modules/lustre"

  automatic_backup_retention_days   = 7
  copy_tags_to_backups              = true
  daily_automatic_backup_start_time = "05:00"
  data_compression_type             = "LZ4"
  deployment_type                   = "PERSISTENT_1"
  drive_cache_type                  = "READ"
  file_system_type_version          = "2.12"

  log_configuration = {
    level = "FAILURE_ONLY"
  }

  per_unit_storage_throughput = 50

  root_squash_configuration = {
    root_squash = "365534:65534"
  }


  tags = local.tags
}

module "fsx_lustre_persistent_2" {
  source = "../../modules/lustre"

  automatic_backup_retention_days   = 7
  copy_tags_to_backups              = true
  daily_automatic_backup_start_time = "05:00"
  data_compression_type             = "LZ4"
  deployment_type                   = "PERSISTENT_2"

  tags = local.tags
}

module "fsx_lustre_disabled" {
  source = "../../modules/lustre"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.tags
}
