resource "google_compute_instance" "app" {
  name         = "${var.name}-vm"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      # Assegna IP pubblico
    }
  }

  tags   = ["${var.name}-app"]
  labels = var.labels
}
