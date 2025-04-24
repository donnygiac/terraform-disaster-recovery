#Outputs per il modulo AWS Compute
output "instance_ids" {
  description = "Lista degli ID delle istanze EC2"
  value       = aws_instance.app.id
}

output "app_sg_id" {
  description = "ID del Security Group usato per le EC2"
  value       = aws_security_group.app_sg.id
}

output "public_ip" {
  description = "IP pubblico della VM"
  value       = aws_instance.app.public_ip
}