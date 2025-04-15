output "db_instance_id" {
  description = "ID dell'istanza RDS"
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "Endpoint DNS per connettersi al DB"
  value       = aws_db_instance.this.endpoint
}

output "db_sg_id" {
  description = "ID del security group del DB"
  value       = aws_security_group.rds_sg.id
}