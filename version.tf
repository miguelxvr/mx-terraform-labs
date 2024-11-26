provider "aws" {
  region = "us-east-1"
}

terraform { 
    backend "remote" {
    hostname = "app.terraform.io"
    organization = "PUCRS"

    workspaces {
      prefix = "csw242-"
    }
  }
}

data "aws_availability_zones" "available" {}