variable "aws_account_id" {
  description = "The AWS Account ID used for backend bucket naming."
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance."
  type        = string
}


variable "environment" {
  description = "The deployment environment"
  type        = string
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