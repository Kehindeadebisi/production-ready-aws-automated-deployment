data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
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
  description = "Allow SSH access for sandbox management"
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

resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Allow HTTP access to the application load balancer"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "ecs" {
  name        = "ecs-sg"
  description = "Allow traffic from ALB to ECS tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description              = "Allow traffic from ALB"
    from_port                = 3000
    to_port                  = 3000
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.alb.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}




