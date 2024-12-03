provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

#
# Uncomment the following block to enable the remote backend
#
# terraform {
#   required_version = ">= 0.13.1"

#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "NUBOAI"
#     workspaces {
#       prefix = "baseline-nubo-"
#     }
#   }

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 3.63"
#     }
#   }
# }