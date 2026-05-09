data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "devops-challenge-${var.aws_account_id}-${var.aws_region}-tfstate"
    key    = "vpc/terraform.tfstate"
    region = var.aws_region
  }
}

# Use try() function to provide defaults when VPC state doesn't exist
locals {
  vpc_id                    = try(data.terraform_remote_state.vpc.outputs.vpc_id, "vpc-placeholder")
  private_subnets           = try(data.terraform_remote_state.vpc.outputs.private_subnets, [])
  public_subnets            = try(data.terraform_remote_state.vpc.outputs.public_subnets, [])
  alb_security_group_id     = try(data.terraform_remote_state.vpc.outputs.alb_security_group_id, "sg-placeholder")
  ecs_security_group_id     = try(data.terraform_remote_state.vpc.outputs.ecs_security_group_id, "sg-placeholder")
}

module "ecs" {
  source = "../terraform/modules/ecs"
  vpc_id = local.vpc_id
  private_subnets = local.private_subnets
  public_subnets = local.public_subnets
  alb_security_group_id = local.alb_security_group_id
  ecs_security_group_id = local.ecs_security_group_id
  environment = var.environment
  project_name = var.project_name
  common_tags = var.common_tags
  aws_region = var.aws_region
}

module "s3" {
  source = "../terraform/modules/s3"
  environment = var.environment
  project_name = var.project_name
  common_tags  = var.common_tags
}
