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

variable "common_tags" {
  description = "Common tags to apply to resources."
  type        = map(string)
  default     = {
    managedBy = "terraform"
  }
}

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "devops-challenge"
}