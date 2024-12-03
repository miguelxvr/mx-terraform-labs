module "db_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.name_prefix}-sg-db"
  description = "Created by Terraform"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Service database access from within VPC"
      cidr_blocks = "0.0.0.0/0" // data.terraform_remote_state.vpc.outputs.vpc_cidr_block
    },
  ]

  tags = var.tags
}

resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name                    = "${var.name_prefix}-mysql-db"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = <<EOF
   {
    "engine": "mysql",
    "host": "${module.db.db_instance_address}",
    "username": "${module.db.db_instance_username}",
    "password": "${random_password.master.result}",
    "port": "${module.db.db_instance_port}"
   }
EOF
}

module "db" {
  source     = "terraform-aws-modules/rds/aws"
  identifier = "${var.name_prefix}-mysql-db"

  create_db_option_group    = true
  create_db_parameter_group = true
  db_subnet_group_name      = var.subnet_group_name

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine                = "mysql"
  engine_version        = "8.0.28"
  family                = "mysql8.0" # DB parameter group
  major_engine_version  = "8.0"      # DB option group
  instance_class        = "db.t3.micro"
  storage_encrypted     = false
  allocated_storage     = 20
  max_allocated_storage = 100

  username                    = "nfag"
  password                    = random_password.master.result
  manage_master_user_password = false

  port = 3306

  multi_az               = false
  subnet_ids             = var.subnets
  vpc_security_group_ids = [module.db_security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  # enabled_cloudwatch_logs_exports = ["general"]
  # create_cloudwatch_log_group     = true

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
  publicly_accessible     = true

  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7
  # create_monitoring_role                = true
  # monitoring_interval                   = 60

  # parameters = [
  #   {
  #     name  = "character_set_client"
  #     value = "utf8mb4"
  #   },
  #   {
  #     name  = "character_set_server"
  #     value = "utf8mb4"
  #   }
  # ]

  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }

  tags = var.tags
}
