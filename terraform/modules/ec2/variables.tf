variable "environment" {
	description = "The deployment environment."
	type        = string
}
variable "ami_id" {
	description = "AMI ID for the EC2 instance."
	type        = string
}
variable "project_name" {
	description = "Project name for resource naming."
	type        = string
}

variable "common_tags" {
	description = "Common tags to apply to resources."
	type        = map(string)
}



variable "root_volume_device_name" {
	description = "The device name for the root EBS volume (e.g., /dev/xvda)."
	type        = string
	default     = "/dev/xvda"
}
variable "vpc_id" { type = string }
variable "sandbox_security_group_id" { type = string }
variable "instance_type" { type = string }
variable "root_volume_size" { type = number }
variable "private_subnet_id" { type = string }
