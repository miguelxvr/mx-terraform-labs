module "ecs" {
  source = "../modules/ecs"

  name_prefix               = local.name_prefix
  
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  # ALB Variables
  vpc_id                     = module.vpc.vpc_id
  public_subnets             = module.vpc.public_subnets
  enable_deletion_protection = false

  alb_security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  alb_security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  alb_listeners = {
    ex_http = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "ex_ecs"
      }
    }
  }

  alb_target_groups = {
    ex_ecs = {
      backend_protocol                  = "HTTP"
      backend_port                      = "3000"
      target_type                       = "ip"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true

      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }

      create_attachment = false
    }
  }
}
