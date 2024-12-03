module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.name_prefix}-vpc"
  cidr = var.cidr # 10.0.0.0/8 is reserved for EC2-Classic

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  database_subnets = var.database_subnets

  # For publicly accessible DBInstance
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true

  tags = var.tags
  vpc_tags = merge(
    { "Name" = "${var.name_prefix}-vpc" },
    var.tags,
  )
}

module "aws_vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  count  = var.enable_vpc_endpoints ? 1 : 0

  vpc_id = module.aws_vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    s3 = {
      service             = "s3"
      private_dns_enabled = true
      service_type        = "Gateway"
      route_table_ids = flatten([module.aws_vpc.private_route_table_ids])
      tags = merge(
        { "Name" = "${var.name_prefix}-vpc-s3-endpoint" },
        var.tags,
      )
    },
    dynamodb = {
      service             = "dynamodb"
      private_dns_enabled = true
      service_type        = "Gateway"
      route_table_ids = flatten([module.aws_vpc.private_route_table_ids])
      tags = merge(
        { "Name" = "${var.name_prefix}-vpc-dynamodb-endpoint" },
        var.tags,
      )
    },
    secretsmanager = {
      service             = "secretsmanager"
      private_dns_enabled = true
      service_type        = "Interface"
      subnet_ids          = module.aws_vpc.private_subnets
      tags = merge(
        { "Name" = "${var.name_prefix}-vpc-secretsmanager-endpoint" },
        var.tags,
      )
    },
    # ssm = {
    #   service             = "ssm"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    #   security_group_ids  = [aws_security_group.vpc_tls.id]
    # },
    # ssmmessages = {
    #   service             = "ssmmessages"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
    # lambda = {
    #   service             = "lambda"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
    # ecs = {
    #   service             = "ecs"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
    # ecs_telemetry = {
    #   create              = false
    #   service             = "ecs-telemetry"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
    # ec2 = {
    #   service             = "ec2"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    #   security_group_ids  = [aws_security_group.vpc_tls.id]
    # },
    # ec2messages = {
    #   service             = "ec2messages"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
    # ecr_api = {
    #   service             = "ecr.api"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    #   policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    # },
    # ecr_dkr = {
    #   service             = "ecr.dkr"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    #   policy              = data.aws_iam_policy_document.generic_endpoint_policy.EOF
    # },
    # kms = {
    #   service             = "kms"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    #   security_group_ids  = [aws_security_group.vpc_tls.id]
    # },
    # codedeploy = {
    #   service             = "codedeploy"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
    # codedeploy_commands_secure = {
    #   service             = "codedeploy-commands-secure"
    #   private_dns_enabled = true
    #   subnet_ids          = module.aws_vpc.private_subnets
    # },
  }

  tags = var.tags
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.aws_vpc.vpc_id
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect = "Deny"
    actions = ["*"]
    resources = ["*"]

    principals {
      type = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.aws_vpc.vpc_id]
    }
  }
}

module "vpc_id" {
  source = "../ssm/parameter"

  name  = "/vpc/${module.aws_vpc.name}/id"
  type  = "String"
  value = module.aws_vpc.vpc_id
}

module "public_subnets" {
  source = "../ssm/parameter"

  name = "/vpc/${module.aws_vpc.name}/public-subnets"
  type = "StringList"
  value = join(",", module.aws_vpc.public_subnets)
}

module "private_subnets" {
  source = "../ssm/parameter"

  name = "/vpc/${module.aws_vpc.name}/private-subnets"
  type = "StringList"
  value = join(",", module.aws_vpc.private_subnets)
}

module "database_subnets" {
  source = "../ssm/parameter"

  name = "/vpc/${module.aws_vpc.name}/database-subnets"
  type = "StringList"
  value = join(",", module.aws_vpc.database_subnets)
}
