

module "vpc" {
	source = "./terraform/modules/vpc"
    environment = var.environment
    project_name = var.project_name
    common_tags = var.common_tags
}


module "ec2" {
  source                    = "./terraform/modules/ec2"
  vpc_id                    = module.vpc.vpc_id
  sandbox_security_group_id = module.vpc.sandbox_security_group_id
  instance_type             = var.instance_type
  root_volume_size          = var.root_volume_size
  private_subnet_id         = module.vpc.private_subnets[0]
  ami_id                    = var.ami_id
  project_name              = var.project_name
  common_tags               = var.common_tags
  environment               = var.environment
}


