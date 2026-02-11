module "s3" {
  source      = "./terraform/modules/s3"
  environment = var.environment
  project_name = local.project_name
  common_tags  = local.common_tags
}
