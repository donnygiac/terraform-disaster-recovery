output "forwarding_rule_ip" {
  description = "IP pubblico del load balancer"
  value       = google_compute_global_forwarding_rule.https.ip_address
}

output "load_balancer_ip" {
  value       = google_compute_global_forwarding_rule.https.ip_address
  description = "IP pubblico del Load Balancer HTTPS (GCP)"
}

output "forwarding_ip_address" {
  description = "IP pubblico del Load Balancer GCP"
  value       = google_compute_global_forwarding_rule.https.ip_address
}
