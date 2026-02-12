terraform {
  backend "s3" {
    bucket = "fincra3-${var.aws_account_id}-eu-north-1-tfstate"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"
    dynamodb_table = "fincra3-${var.aws_account_id}-eu-north-1-lock-table"
  }
}
