output "forwarding_rule_ip" {
  description = "IP pubblico del load balancer"
  value       = google_compute_global_forwarding_rule.this.ip_address
}
