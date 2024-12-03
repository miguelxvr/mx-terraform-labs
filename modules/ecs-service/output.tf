# Outputs for ECS Service
output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs_service.name
}

output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = module.ecs_service.id
}

output "ecs_service_task_definition_arn" {
  description = "ARN of the ECS service task definition"
  value       = module.ecs_service.task_definition_arn
}