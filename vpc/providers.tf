provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.5"

  required_providers {

    aws = ">= 5.0"

  }

#  backend "s3" {

#    }
}