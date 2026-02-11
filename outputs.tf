
output "bucket_id" {
  description = "name of the bucket"
  value       = module.s3.bucket_id
}

output "bucket_arn" {
  description = "bucket arn"
  value       = module.s3.bucket_arn
}

