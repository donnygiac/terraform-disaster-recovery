output "instance_name" {
  description = "Nome dell'istanza GCP"
  value       = google_compute_instance.app.name
}

output "instance_zone" {
  description = "Zona in cui risiede l'istanza"
  value       = google_compute_instance.app.zone
}

output "instance_ip" {
  description = "IP pubblico dell'istanza"
  value       = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
}