resource "google_compute_network" "this" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name          = "${var.name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.this.id
}

resource "google_compute_firewall" "custom" {
  for_each = { for rule in var.firewall_rules : rule.name => rule }

  name    = "${var.name}-allow-${each.key}"
  network = google_compute_network.this.name

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }

  direction     = each.value.direction
  source_ranges = each.value.source_ranges
  target_tags   = each.value.target_tags
}
