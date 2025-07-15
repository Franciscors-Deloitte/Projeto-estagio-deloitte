################################################################################
# EC2 Instance
################################################################################

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

  monitoring              = var.enable_monitoring
  availability_zone       = var.availability_zone
  private_ip              = var.private_ip
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = var.tags
}

################################################################################
# EBS Volume
################################################################################

resource "aws_ebs_volume" "this" {
  count = var.create_ebs ? 1 : 0

  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_volume_type

  tags = var.tags
}

resource "aws_volume_attachment" "this" {
  count = var.create_ebs ? 1 : 0

  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.this[0].id
  instance_id = aws_instance.this[0].id
  force_detach = true
}

################################################################################
# Elastic IP
################################################################################

resource "aws_eip" "this" {
  count    = var.attach_eip ? 1 : 0
  instance = aws_instance.this[0].id
  vpc      = true
}