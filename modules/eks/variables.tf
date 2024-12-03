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

variable "control_plane_subnets" {
  type        = list(string)
  description = "List of IDs of control plane subnets"
  default     = null
}

variable "enable_cluster_creator_admin_permissions" {
  type        = bool
  description = "Enable cluster creator admin permissions"
  default     = false
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = false
}