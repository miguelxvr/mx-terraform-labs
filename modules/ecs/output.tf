# ECS Outputs
output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = module.ecs.cluster_arn
}

# ALB Outputs
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.dns_name
}

output "alb_target_groups" {
  description = "The ARNs of the target groups"
  value       = module.alb.target_groups
}

output "alb_security_group_id" {
  description = "The ID of the security group of the Application Load Balancer"
  value       = module.alb.security_group_id
}
