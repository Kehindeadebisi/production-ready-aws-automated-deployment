variable "vpc_id" {
  description = "VPC ID for EC2 instance."
  type        = string
}

variable "private_subnet_id" {
  description = "Subnet ID for EC2 instance."
  type        = string
}

variable "sandbox_security_group_id" {
  description = "Security Group ID for EC2 instance."
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance."
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming."
  type        = string
  default     = "devops-challenge"
}

variable "common_tags" {
  description = "Common tags to apply to resources."
  type        = map(string)
  default     = {
    managedBy = "terraform"
  }
}
variable "root_volume_device_name" {
  description = "The device name for the root EBS volume (e.g., /dev/xvda)."
  type        = string
  default     = "/dev/xvda"
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "sandbox"
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