output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this[0].id
}

output "private_ip" {
  description = "The private IP address of the instance"
  value       = aws_instance.this[0].private_ip
}

output "public_ip" {
  description = "The public IP address of the instance (if applicable)"
  value       = aws_instance.this[0].public_ip
}

################################################################################
# Elastic IP
################################################################################

output "eip_public_ip" {
  description = "Elastic IP public IP address"
  value       = var.attach_eip ? aws_eip.this[0].public_ip : null
}