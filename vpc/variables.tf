variable "aws_account_id" {
  description = "The AWS Account ID used for backend bucket naming."
  type        = string
}
variable "aws_region" {
  description = "The AWS region for deployment."
  type        = string
  default     = "us-east-1"
}
variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "common_tags" {
  description = "Common tags to apply to resources."
  type        = map(string)
  default     = {
    managedBy = "terraform"
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.nano"
}

variable "root_volume_size" {
  description = "Root EBS volume size (GiB)"
  type        = number
  default     = 8
}