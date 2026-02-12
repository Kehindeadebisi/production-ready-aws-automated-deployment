provider "aws" {
  region = "eu-north-1"
}

terraform {
  required_version = ">= 1.5"

  required_providers {

    aws = ">= 5.0"

  }

#  backend "s3" {

#    }
}