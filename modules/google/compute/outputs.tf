output "instance_names" {
  description = "Nomi delle istanze GCP"
  value       = google_compute_instance.app[*].name
}

output "instance_ips" {
  description = "IP pubblici delle VM"
  value       = google_compute_instance.app[*].network_interface[0].access_config[0].nat_ip
}
