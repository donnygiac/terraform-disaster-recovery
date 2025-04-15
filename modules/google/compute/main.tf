resource "google_compute_instance" "app" {
  count        = var.instance_count
  name         = "${var.name}-vm-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      # Assegna IP pubblico
    }
  }

  tags   = var.tags
  labels = var.labels
}
