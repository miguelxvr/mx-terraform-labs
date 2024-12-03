# ECS Service Module
module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = "${var.name_prefix}-ecs-service"
  cluster_arn = var.cluster_arn

  cpu    = var.cpu
  memory = var.memory

  container_definitions = var.container_definitions

  load_balancer = {
    service = {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  subnet_ids = var.vpc_public_subnets

  security_group_rules = var.security_group_rules

  create_iam_role              = false
  create_task_definition       = true
  create_task_exec_iam_role    = false
  create_task_exec_policy      = false
  create_tasks_iam_role        = false
  create_security_group        = false
  task_exec_iam_role_arn       = var.task_exec_iam_role_arn
}
