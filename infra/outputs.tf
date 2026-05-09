
output "bucket_id" {
  description = "name of the bucket"
  value       = module.s3.bucket_id
}

output "bucket_arn" {
  description = "bucket arn"
  value       = module.s3.bucket_arn
}

output "app_lb_dns" {
  description = "DNS name of the app load balancer"
  value       = module.ecs.app_lb_dns
}

output "ecr_repository_url" {
  description = "ECR repository URL for the app"
  value       = module.ecs.ecr_repository_url
}

