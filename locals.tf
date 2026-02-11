locals {
    project_name="fincra"
  common_tags = {
    Environment = var.environment
    managedBy   = "terraform"
  }
}