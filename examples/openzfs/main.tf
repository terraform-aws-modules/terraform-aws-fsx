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
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-fsx"
  }
}

################################################################################
# FSx Module
################################################################################

module "fsx_openzfs" {
  source = "../../modules/openzfs"

  name = local.name

  # File system
  automatic_backup_retention_days   = 7
  copy_tags_to_backups              = true
  copy_tags_to_volumes              = true
  daily_automatic_backup_start_time = "05:00"
  deployment_type                   = "MULTI_AZ_1"

  disk_iops_configuration = {
    iops = 3072
    mode = "USER_PROVISIONED"
  }

  preferred_subnet_id = module.vpc.private_subnets[0]

  root_volume_configuration = {
    copy_tags_to_snapshots = true
    data_compression_type  = "LZ4"

    nfs_exports = {
      client_configurations = [
        {
          clients = "10.0.1.0/24"
          options = ["async", "rw"]
        },
        {
          clients = "*"
          options = ["sync", "rw"]
        }
      ]
    }

    read_only       = false
    record_size_kib = 128

    user_and_group_quotas = [
      {
        id                         = 0
        storage_capacity_quota_gib = 128
        type                       = "GROUP"
      },
      {
        id                         = 0
        storage_capacity_quota_gib = 64
        type                       = "USER"
      },
    ]
  }

  route_table_ids               = module.vpc.private_route_table_ids
  skip_final_backup             = true
  storage_capacity              = 1024
  storage_type                  = "SSD"
  subnet_ids                    = slice(module.vpc.private_subnets, 0, 2)
  throughput_capacity           = 160
  weekly_maintenance_start_time = "1:06:00"

  # Volume(s)
  volumes = {
    ex-one = {
      copy_tags_to_snapshots = true
      data_compression_type  = "LZ4"
      delete_volume_options  = ["DELETE_CHILD_VOLUMES_AND_SNAPSHOTS"]
      name                   = "example"

      nfs_exports = {
        client_configurations = [
          {
            clients = "10.0.1.0/24"
            options = ["async", "rw"]
          },
          {
            clients = "*"
            options = ["sync", "rw"]
          }
        ]
      }

      read_only                        = false
      record_size_kib                  = 128
      storage_capacity_quota_gib       = 30
      storage_capacity_reservation_gib = 20

      user_and_group_quotas = [
        {
          id                         = 0
          storage_capacity_quota_gib = 128
          type                       = "GROUP"
        },
        {
          id                         = 0
          storage_capacity_quota_gib = 64
          type                       = "USER"
        },
      ]

      tags = {
        ExtraTags = "yes"
      }
    }
  }

  # Security group
  security_group_ingress_rules = {
    in = {
      cidr_ipv4   = module.vpc.vpc_cidr_block
      description = "Allow all traffic from the VPC"
      from_port   = 0
      to_port     = 0
      ip_protocol = "tcp"
    }
  }

  tags = local.tags
}

module "fsx_openzfs_disabled" {
  source = "../../modules/openzfs"

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

  enable_nat_gateway = false

  tags = local.tags
}
