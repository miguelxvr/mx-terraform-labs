variable "tags" {
  type        = map(string)
  description = "The labels to assign to the resources"
}

variable "name_prefix" {
  type        = string
  description = "The prefix used in all of the resource names"
}

variable "cidr" {
  type        = string
  description = "Range of IPv4 addresses for the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of IDs of private subnets"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "List of IDs of public subnets"
  default     = []
}

variable "database_subnets" {
  type        = list(string)
  description = "List of IDs of database subnets"
  default     = []
}

variable "enable_vpc_endpoints" {
  description = "Flag to enable or disable VPC endpoints"
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Flag to enable or disable NAT gateway"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Flag to enable or disable single NAT gateway"
  type        = bool
  default     = true
}
