


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs             = ["eu-north-1a", "eu-north-1b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.common_tags
}

resource "aws_security_group" "sandbox" {
  name        = "sandbox-sg"
  description = "Allow SSH access to sandbox"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH from anywhere (sandbox only)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}




