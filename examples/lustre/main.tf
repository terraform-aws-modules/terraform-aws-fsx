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
    Repository = "https://github.com/clowdhaus/terraform-aws-fsx"
  }
}

################################################################################
# FSx Module
################################################################################

module "fsx_lustre_persistent_1" {
  source = "../../modules/lustre"

  name = "${local.name}-persistent1"

  # File system
  automatic_backup_retention_days = 0
  data_compression_type           = "LZ4"
  deployment_type                 = "PERSISTENT_1"
  file_system_type_version        = "2.12"

  log_configuration = {
    level = "ERROR_ONLY"
  }

  per_unit_storage_throughput = 50

  root_squash_configuration = {
    root_squash = "365534:65534"
  }

  storage_capacity              = 1200
  storage_type                  = "SSD"
  subnet_ids                    = slice(module.vpc.private_subnets, 0, 1)
  weekly_maintenance_start_time = "1:06:00"

  # Data Repository Association(s)
  data_repository_associations = {
    example = {
      batch_import_meta_data_on_create = true
      data_repository_path             = "s3://${module.s3_bucket.s3_bucket_id}"
      delete_data_in_filesystem        = false
      file_system_path                 = "/persistent1/data"
      imported_file_chunk_size         = 128

      s3 = {
        auto_export_policy = {
          events = ["NEW", "CHANGED", "DELETED"]
        }

        auto_import_policy = {
          events = ["NEW", "CHANGED", "DELETED"]
        }
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
      protocol    = "tcp"
    }
  }
  security_group_egress_rules = {
    out = {
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all traffic"
      ip_protocol = "-1"
    }
  }

  tags = local.tags
}

module "fsx_lustre_persistent_2" {
  source = "../../modules/lustre"

  name = "${local.name}-persistent2"

  # File system
  automatic_backup_retention_days = 0
  data_compression_type           = "LZ4"
  deployment_type                 = "PERSISTENT_2"
  file_system_type_version        = "2.12"

  log_configuration = {
    level = "ERROR_ONLY"
  }

  per_unit_storage_throughput = 125

  root_squash_configuration = {
    root_squash = "365534:65534"
  }

  storage_capacity              = 1200
  storage_type                  = "SSD"
  subnet_ids                    = slice(module.vpc.private_subnets, 0, 1)
  weekly_maintenance_start_time = "1:06:00"

  # Data Repository Association(s)
  data_repository_associations = {
    example = {
      batch_import_meta_data_on_create = true
      data_repository_path             = "s3://${module.s3_bucket.s3_bucket_id}"
      delete_data_in_filesystem        = false
      file_system_path                 = "/persistent2/data"
      imported_file_chunk_size         = 128

      s3 = {
        auto_export_policy = {
          events = ["NEW", "CHANGED", "DELETED"]
        }

        auto_import_policy = {
          events = ["NEW", "CHANGED", "DELETED"]
        }
      }
    }
  }

  # Security group
  security_group_name = local.name
  security_group_ingress_rules = {
    in = {
      cidr_ipv4   = module.vpc.vpc_cidr_block
      description = "Allow all traffic from the VPC"
      from_port   = 0
      to_port     = 0
      protocol    = "tcp"
    }
  }
  security_group_egress_rules = {
    out = {
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all traffic"
      ip_protocol = "-1"
    }
  }

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

  enable_nat_gateway = false

  tags = local.tags
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  # Example only
  force_destroy = true

  bucket_prefix = local.name
  acl           = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  tags = local.tags
}
