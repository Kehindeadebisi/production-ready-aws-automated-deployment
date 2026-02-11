variable "project_name" {
	description = "Project name for resource naming."
	type        = string
}

variable "common_tags" {
	description = "Common tags to apply to resources."
	type        = map(string)
}
variable "environment" {
	 description = "The deployment environment"
	 type = string
}

