# Data source for current AWS account ID
data "aws_caller_identity" "current" {}

# S3 Bucket for sandbox
resource "aws_s3_bucket" "sandbox" {
  bucket = "${var.project_name}-${var.environment}-bucket--${data.aws_caller_identity.current.account_id}"

  tags = merge(var.common_tags, {
    Name    = "${var.project_name}-bucket"
    project = "${var.project_name}-${var.environment}"
  })
}

# Block public access
resource "aws_s3_bucket_public_access_block" "sandbox" {
  bucket = aws_s3_bucket.sandbox.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versioning
resource "aws_s3_bucket_versioning" "sandbox" {
  bucket = aws_s3_bucket.sandbox.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "sandbox" {
  bucket = aws_s3_bucket.sandbox.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}