# ECS Variables
variable "name_prefix" {
  description = "Prefix for the ECS resources"
  type        = string
}

variable "fargate_capacity_providers" {
  description = "Capacity providers for ECS Fargate"
  type        = map(any)
  default = {
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
}

# ALB Variables

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false
}

variable "alb_security_group_ingress_rules" {
  description = "Ingress rules for ALB security group"
  type        = map(any)
}

variable "alb_security_group_egress_rules" {
  description = "Egress rules for ALB security group"
  type        = map(any)
}

variable "alb_listeners" {
  description = "ALB listener configurations"
  type        = map(any)
}

variable "alb_target_groups" {
  description = "ALB target group configurations"
  type        = map(any)
}
