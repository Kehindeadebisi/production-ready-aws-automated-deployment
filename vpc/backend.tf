terraform {
  backend "s3" {
    bucket = "devops-challenge-${var.aws_account_id}-${var.aws_region}-tfstate"
    key    = "vpc/terraform.tfstate"
    region = var.aws_region
    dynamodb_table = "devops-challenge-${var.aws_account_id}-${var.aws_region}-lock-table"
  }
}
