# IAM Role for EC2
resource "aws_iam_role" "sandbox_ec2_role" {
  name = "sandbox-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "sandbox-ec2-role"
  })
}

# IAM Policy for EC2 (example: S3 access)
resource "aws_iam_policy" "sandbox_ec2_policy" {
  name = "sandbox-ec2-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "sandbox_ec2_attach" {
  role       = aws_iam_role.sandbox_ec2_role.name
  policy_arn = aws_iam_policy.sandbox_ec2_policy.arn
}

# Instance profile
resource "aws_iam_instance_profile" "sandbox_ec2_profile" {
  name = "sandbox-ec2-profile"
  role = aws_iam_role.sandbox_ec2_role.name
}
