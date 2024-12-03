module "ecs_service" {
  source = "../modules/ecs-service"

  name_prefix        = local.name_prefix
  cluster_arn        = module.ecs.ecs_cluster_arn
  cpu                = 1024
  memory             = 4096
  container_name     = "csw242-container"
  container_port     = 8080
  target_group_arn   = module.ecs.alb_target_groups["ex_ecs"].arn
  vpc_public_subnets = module.vpc.public_subnets

  security_group_rules = {
    alb_ingress_3000 = {
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Service port"
      source_security_group_id = module.ecs.alb_security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  task_exec_iam_role_arn = "arn:aws:iam::533267418676:role/LabRole"
  container_definitions = {
    fluent-bit = {
      cpu       = 512
      memory    = 1024
      essential = true
      image     = "906394416424.dkr.ecr.us-west-2.amazonaws.com/aws-for-fluent-bit:stable"
      firelens_configuration = {
        type = "fluentbit"
      }
      memory_reservation = 50
    }
    my-container = {
      cpu       = 512
      memory    = 1024
      essential = true
      image     = "public.ecr.aws/aws-containers/ecsdemo-frontend:776fd50"
      port_mappings = [
        {
          name          = "csw242-container"
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      readonly_root_filesystem = false
      dependencies = [{
        containerName = "fluent-bit"
        condition     = "START"
      }]
      enable_cloudwatch_logging = false
      log_configuration = {
        logDriver = "awsfirelens"
        options = {
          Name                    = "firehose"
          region                  = "us-east-1"
          delivery_stream         = "csw242-stream"
          log-driver-buffer-limit = "2097152"
        }
      }
      memory_reservation = 100
    }
  }
}
