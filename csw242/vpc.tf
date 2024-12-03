module "vpc" {
  source = "../modules/vpc"

  name_prefix = local.name_prefix

  cidr = "20.10.0.0/16"

  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]

  enable_vpc_endpoints = false
  enable_nat_gateway   = false

  tags = local.tags
}
