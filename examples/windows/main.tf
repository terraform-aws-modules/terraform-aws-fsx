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

module "fsx_windows" {
  source = "../../modules/windows"

  # File system
  active_directory_id = aws_directory_service_directory.this.id
  aliases             = ["filesystem1.example.com"]

  audit_log_configuration = {
    file_access_audit_log_level       = "SUCCESS_AND_FAILURE"
    file_share_access_audit_log_level = "SUCCESS_AND_FAILURE"
  }

  automatic_backup_retention_days   = 7
  copy_tags_to_backups              = true
  daily_automatic_backup_start_time = "05:00"
  deployment_type                   = "MULTI_AZ_1"

  disk_iops_configuration = {
    iops = 3072
    mode = "AUTOMATIC"
  }

  preferred_subnet_id = module.vpc.private_subnets[0]

  # For reference
  # self_managed_active_directory = {
  #   dns_ips     = aws_directory_service_directory.this.dns_ip_addresses
  #   domain_name = aws_directory_service_directory.this.name
  #   password    = aws_directory_service_directory.this.password
  #   username    = "Admin"
  # }

  skip_final_backup             = true
  storage_capacity              = 1024
  storage_type                  = "SSD"
  subnet_ids                    = module.vpc.private_subnets
  throughput_capacity           = 512
  weekly_maintenance_start_time = "1:06:00"

  # Security group
  security_group_ingress_rules = {
    cidr_ipv4   = module.vpc.vpc_cidr_block
    description = "Allow all traffic from the VPC"
    from_port   = 0
    protocol    = "tcp"
    to_port     = 0
  }

  tags = local.tags
}

module "fsx_windows_disabled" {
  source = "../../modules/windows"

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
  name     = local.name
  password = "SuperSecretPassw0rd"
  type     = "MicrosoftAD"

  vpc_settings {
    subnet_ids = module.vpc.private_subnets
    vpc_id     = module.vpc.vpc_id
  }

  tags = local.tags
}
