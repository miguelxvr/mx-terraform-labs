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