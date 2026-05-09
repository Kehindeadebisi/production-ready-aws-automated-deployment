locals {
    project_name="devops-challenge"
  common_tags = {
    Environment = var.environment
    managedBy   = "terraform"
  }
}