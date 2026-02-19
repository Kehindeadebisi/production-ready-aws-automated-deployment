# Shared variables for sandbox environment
environment = "sandbox"

# VPC-specific variables (using defaults from variables.tf)
# vpc_cidr = "10.0.0.0/16" 
# public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

# Infra-specific variables  
ami_id           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI for eu-north-1
instance_type    = "t3.nano"
root_volume_size = 8