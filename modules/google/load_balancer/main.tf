resource "google_compute_health_check" "http" {
  name               = "${var.name}-hc"
  check_interval_sec = var.health_check_interval
  timeout_sec        = var.health_check_timeout
  healthy_threshold  = var.health_check_healthy_threshold
  unhealthy_threshold = var.health_check_unhealthy_threshold

  http_health_check {
    request_path = var.health_check_path
    port         = var.health_check_port
  }
}

resource "google_compute_backend_service" "this" {
  name                  = "${var.name}-backend"
  load_balancing_scheme = "EXTERNAL"
  protocol              = var.backend_protocol
  port_name             = var.backend_port_name
  timeout_sec           = var.backend_timeout_sec
  health_checks         = [google_compute_health_check.http.id]

  backend {
    group = var.instance_group_self_link
  }

  enable_cdn = var.enable_cdn
}

resource "google_compute_url_map" "this" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.this.self_link
}

resource "google_compute_target_http_proxy" "this" {
  name   = "${var.name}-proxy"
  url_map = google_compute_url_map.this.self_link
}

resource "google_compute_global_forwarding_rule" "this" {
  name        = "${var.name}-fw"
  target      = google_compute_target_http_proxy.this.self_link
  port_range  = var.forwarding_port_range
  ip_protocol = var.forwarding_ip_protocol
}
