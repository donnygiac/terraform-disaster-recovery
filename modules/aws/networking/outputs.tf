output "vpc_id" {
  description = "ID della VPC creata"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "Lista degli ID delle subnet pubbliche create"
  value       = aws_subnet.public[*].id
}
