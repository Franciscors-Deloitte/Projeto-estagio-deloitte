resource "aws_instance" "this" {
  count = var.create ? 1 : 0

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  user_data                   = var.user_data
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address

  monitoring                  = var.enable_monitoring
  availability_zone           = var.availability_zone
  private_ip                  = var.private_ip
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = var.tags
}

################################################################################
# Elastic IP
################################################################################

resource "aws_eip" "this" {
  count    = var.attach_eip ? 1 : 0
  instance = aws_instance.this[0].id
  vpc      = true
}