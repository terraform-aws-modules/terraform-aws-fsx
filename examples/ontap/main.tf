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

module "fsx_ontap" {
  source = "../../modules/ontap"

  # File system
  automatic_backup_retention_days   = 7
  daily_automatic_backup_start_time = "05:00"
  deployment_type                   = "MULTI_AZ_1"

  disk_iops_configuration = {
    iops = 3072
    mode = "AUTOMATIC"
  }

  fsx_admin_password              = "avoid-plaintext-passwords"
  ha_pairs                        = 2
  preferred_subnet_id             = module.vpc.private_subnets[0]
  route_table_ids                 = module.vpc.private_route_table_ids
  storage_capacity                = 1024
  subnet_ids                      = module.vpc.private_subnets
  throughput_capacity_per_ha_pair = 3072
  weekly_maintenance_start_time   = "1:06:00"

  # Storage Virtual Machine(s)
  storage_virtual_machines = {
    ex-basic = {
      name = "basic"

      volumes = {
        ex-basic = {
          name                       = "basic"
          junction_path              = "/test"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true
        }
      }
    }
    ex-other = {
      name                       = "one"
      root_volume_security_style = "NTFS"
      svm_admin_password         = "avoid-plaintext-passwords"

      volumes = {
        ex-other = {
          name                       = "other"
          junction_path              = "/test"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          tiering_policy = {
            name           = "AUTO"
            cooling_period = 31
          }
        }
        ex-snaplock = {
          junction_path              = "/snaplock_audit_log"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          snaplock_configuration = {
            audit_log_volume           = true
            privileged_delete          = "PERMANENTLY_DISABLED"
            snaplock_type              = "ENTERPRISE"
            volume_append_mode_enabled = true

            autocommit_period = {
              type  = "DAYS"
              value = 14
            }

            retention_period = {
              default_retention = {
                type  = "DAYS"
                value = 30
              }

              maximum_retention = {
                type  = "MONTHS"
                value = 9
              }

              minimum_retention = {
                type  = "HOURS"
                value = 24
              }
            }
          }
        }
      }
    }
    ex-active-directory = {
      active_directory_configuration = {
        netbios_name = "mysvm"
        self_managed_active_directory_configuration = {
          dns_ips     = ["10.0.0.111", "10.0.0.222"]
          domain_name = "corp.example.com"
          password    = "avoid-plaintext-passwords"
          username    = "Admin"
        }
      }

      volumes = {
        ex-snaplock-ent = {
          junction_path              = "/snaplock_audit_log"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          snaplock_configuration = {
            snaplock_type = "ENTERPRISE"
          }

          bypass_snaplock_enterprise_retention = true
        }
      }
    }
  }

  # Security group
  security_group_ingress_rules = {
    cidr_ipv4   = module.vpc.vpc_cidr_block
    description = "Allow all traffic from the VPC"
    from_port   = 0
    protocol    = "tcp"
    to_port     = 0
  }
  security_group_egress_rules = {
    cidr_ipv4   = "0.0.0.0/0"
    description = "Allow all traffic"
    from_port   = 0
    protocol    = "tcp"
    to_port     = 0
  }

  tags = local.tags
}

module "fsx_ontap_disabled" {
  source = "../../modules/ontap"

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
