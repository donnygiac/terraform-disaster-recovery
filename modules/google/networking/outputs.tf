output "network_name" {
  description = "Nome della rete VPC su GCP"
  value       = google_compute_network.this.name
}

output "subnetwork_name" {
  description = "Nome della subnet GCP"
  value       = google_compute_subnetwork.this.name
}
