# General Variables
variable "name_prefix" {
  description = "Prefix for ECS service name"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster"
  type        = string
}

# ECS Service Variables
variable "cpu" {
  description = "CPU units for the ECS service"
  type        = number
  default     = 1024
}

variable "memory" {
  description = "Memory units for the ECS service"
  type        = number
  default     = 4096
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "container_definitions" {
  description = "Container definitions for the ECS task"
  type        = any
}

# Load Balancer Variables
variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

# Network Configuration
variable "vpc_public_subnets" {
  description = "List of public subnet IDs for the ECS service"
  type        = list(string)
}

# Security Group Rules
variable "security_group_rules" {
  description = "Security group rules for the ECS service"
  type        = any
}

# IAM Role
variable "task_exec_iam_role_arn" {
  description = "IAM Role ARN for the ECS task execution"
  type        = string
}
