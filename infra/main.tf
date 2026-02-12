data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "fincra3-${var.aws_account_id}-eu-north-1-tfstate"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"
  }
}

module "ec2" {
  source = "../terraform/modules/ec2"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  sandbox_security_group_id = data.terraform_remote_state.vpc.outputs.sandbox_security_group_id
  ami_id = var.ami_id
  instance_type = var.instance_type
  root_volume_size = var.root_volume_size
  environment = var.environment
  common_tags = var.common_tags
  project_name = "var.project_name"
}

module "s3" {
  source = "../terraform/modules/s3"
  environment = var.environment
  project_name = "fincra"
  common_tags  = var.common_tags
}
