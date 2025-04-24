output "primary_record_name" {
  description = "Record DNS primario creato"
  value       = aws_route53_record.primary.name
}

output "secondary_record_name" {
  description = "Record DNS secondario creato"
  value       = aws_route53_record.secondary.name
}
