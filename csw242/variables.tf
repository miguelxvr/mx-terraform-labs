variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "20.10.0.0/16"
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
}

variable "database_subnets" {
  description = "A list of CIDR blocks for the database subnets"
  type        = list(string)
  default     = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]
}

