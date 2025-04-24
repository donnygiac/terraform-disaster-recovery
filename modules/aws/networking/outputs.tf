output "vpc_id" {
  description = "ID della VPC creata"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID della subnet pubblica"
  value       = aws_subnet.public.id
}

