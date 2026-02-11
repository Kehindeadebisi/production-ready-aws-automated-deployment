resource "aws_instance" "sandbox" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.sandbox_security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.sandbox_ec2_profile.name

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-instance"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
