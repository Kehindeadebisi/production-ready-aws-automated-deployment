output "app_lb_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app_lb.dns_name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app_repo.repository_url
}