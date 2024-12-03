variable "tags" {
  type        = map(string)
  description = "The labels to assign to the resources"
}

variable "name_prefix" {
  type        = string
  description = "The prefix used in all of the resource names"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
  default     = null
}

variable "subnets" {
  type        = list(string)
  description = "List of IDs of database subnets"
  default     = null
}

variable "subnet_group_name" {
  type        = string
  description = "Name of database subnet group"
  default     = null
}

variable "username" {
  type        = string
  description = "The instance username"
  default     = "admin"
}

variable "allocated_storage" {
  type        = number
  description = "The amount of allocated storage in gigabytes"
  default     = 60
}

variable "max_allocated_storage" {
  type        = number
  description = "The maximum amount of allocated storage in gigabytes"
  default     = 100
}

variable "instance_class" {
  type        = string
  description = "The instance class"
  default     = "db.t3.micro"
}


variable "monitoring_interval" {
  type        = number
  description = "The interval in seconds between points when Enhanced Monitoring metrics are collected"
  default     = 0
}
