output "id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this[0].id
}

output "arn" {
  description = "The ARN of the instance"
  value       = aws_instance.this[0].arn
}

output "instance_state" {
  description = "The state of the instance"
  value       = aws_instance.this[0].instance_state
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value       = aws_instance.this[0].private_ip
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable"
  value       = var.attach_eip ? aws_eip.this[0].public_ip : aws_instance.this[0].public_ip
}

output "ami" {
  description = "AMI ID that was used to create the instance"
  value       = aws_instance.this[0].ami
}

output "ebs_volumes" {
  description = "Map of EBS volumes created and their attributes"
  value       = aws_ebs_volume.this
}

output "root_block_device" {
  description = "Root block device information"
  value       = aws_instance.this[0].root_block_device
}