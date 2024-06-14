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

module "fsx_ontap" {
  source = "../../modules/ontap"

  name = local.name

  # File system
  automatic_backup_retention_days   = 7
  daily_automatic_backup_start_time = "05:00"
  deployment_type                   = "MULTI_AZ_1"

  disk_iops_configuration = {
    iops = 3072
    mode = "USER_PROVISIONED"
  }

  fsx_admin_password            = "avoidPlaintextPasswords1"
  preferred_subnet_id           = module.vpc.private_subnets[0]
  route_table_ids               = module.vpc.private_route_table_ids
  storage_capacity              = 1024
  subnet_ids                    = slice(module.vpc.private_subnets, 0, 2)
  throughput_capacity           = 128
  weekly_maintenance_start_time = "1:06:00"

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
    ex-flexgroup = {
      name = "flexgroup"

      volumes = {
        ex-flexgroup = {
          name                       = "flexgroup"
          junction_path              = "/test"
          size_in_bytes              = 1024000000000
          storage_efficiency_enabled = true
          volume_style               = "FLEXGROUP"
          aggregate_configuration = {
            constituents_per_aggregate = 9
          }
        }
      }
    }
    ex-other = {
      name                       = "one"
      root_volume_security_style = "NTFS"
      svm_admin_password         = "avoid-plaintext-passwords1"

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
          name                       = "snaplock"
          junction_path              = "/snaplock_audit_log"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          bypass_snaplock_enterprise_retention = true
          snaplock_configuration = {
            audit_log_volume           = true
            privileged_delete          = "PERMANENTLY_DISABLED"
            snaplock_type              = "ENTERPRISE"
            volume_append_mode_enabled = false

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
          dns_ips     = aws_directory_service_directory.this.dns_ip_addresses
          domain_name = aws_directory_service_directory.this.name
          password    = aws_directory_service_directory.this.password
          username    = "Admin"
        }
      }

      volumes = {
        ex-snaplock-ent = {
          name                       = "snaplock_ent"
          junction_path              = "/log"
          size_in_megabytes          = 1024
          storage_efficiency_enabled = true

          bypass_snaplock_enterprise_retention = true
          snaplock_configuration = {
            snaplock_type = "ENTERPRISE"
          }
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
      ip_protocol = "tcp"
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

  enable_nat_gateway = false

  tags = local.tags
}

resource "aws_directory_service_directory" "this" {
  edition  = "Standard"
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  type     = "MicrosoftAD"

  vpc_settings {
    subnet_ids = slice(module.vpc.private_subnets, 0, 2)
    vpc_id     = module.vpc.vpc_id
  }

  tags = local.tags
}
