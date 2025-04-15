output "alb_dns_name" {
  description = "DNS del Load Balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del Load Balancer (utile per Route53)"
  value       = aws_lb.this.zone_id
}

output "forwarding_dns" {
  description = "DNS name del Load Balancer AWS"
  value       = aws_lb.this.dns_name
}

output "forwarding_zone_id" {
  description = "Zone ID del Load Balancer AWS"
  value       = aws_lb.this.zone_id
}
