# Health check
resource "google_compute_health_check" "https" {
  name               = "${var.name}-hc"
  check_interval_sec = var.health_check_interval
  timeout_sec        = var.health_check_timeout
  healthy_threshold  = var.health_check_healthy_threshold
  unhealthy_threshold = var.health_check_unhealthy_threshold

  https_health_check {
    request_path = var.health_check_path
    port         = var.health_check_port
  }
}

# Certificato gestito da Google
resource "google_compute_managed_ssl_certificate" "cert" {
  name = "${var.name}-cert"
  managed {
    domains = [var.domain_name]
  }
}

# Backend service
resource "google_compute_backend_service" "backend" {
  name                  = "${var.name}-backend"
  load_balancing_scheme = "EXTERNAL"
  protocol              = var.backend_protocol
  port_name             = var.backend_port_name
  timeout_sec           = var.backend_timeout_sec
  health_checks         = [google_compute_health_check.https.id]

  backend {
    group = var.instance_group_self_link
  }

  enable_cdn = var.enable_cdn
}

# URL map per HTTPS (normale routing)
resource "google_compute_url_map" "https" {
  name            = "${var.name}-url-map-https"
  default_service = google_compute_backend_service.backend.self_link
}

# URL map per HTTP (redirect a HTTPS)
resource "google_compute_url_map" "http" {
  name = "${var.name}-url-map-http"

  default_url_redirect {
    https_redirect = true
    strip_query    = false
  }
}

# Proxy HTTPS
resource "google_compute_target_https_proxy" "https" {
  name             = "${var.name}-https-proxy"
  url_map          = google_compute_url_map.https.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.cert.id]
}

# Proxy HTTP (redirect)
resource "google_compute_target_http_proxy" "http" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.http.self_link
}

# Forwarding rule HTTP
resource "google_compute_global_forwarding_rule" "http" {
  name        = "${var.name}-fw-http"
  target      = google_compute_target_http_proxy.http.self_link
  port_range  = var.forwarding_http_port_range
  ip_protocol = var.forwarding_ip_protocol
}

# Forwarding rule HTTPS
resource "google_compute_global_forwarding_rule" "https" {
  name        = "${var.name}-fw-https"
  target      = google_compute_target_https_proxy.https.self_link
  port_range  = var.forwarding_https_port_range
  ip_protocol = var.forwarding_ip_protocol
}
