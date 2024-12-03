# ECS Cluster
module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "${var.name_prefix}-ecs"

  fargate_capacity_providers = var.fargate_capacity_providers
}

# ALB
module "alb" {
  source  = "terraform-aws-modules/alb/aws"

  name                   = "${var.name_prefix}-alb"
  load_balancer_type     = "application"
  vpc_id                 = var.vpc_id
  subnets                = var.public_subnets
  enable_deletion_protection = var.enable_deletion_protection

  security_group_ingress_rules = var.alb_security_group_ingress_rules
  security_group_egress_rules  = var.alb_security_group_egress_rules

  listeners = var.alb_listeners

  target_groups = var.alb_target_groups
}
