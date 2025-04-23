resource "google_sql_database_instance" "this" {
  name             = var.name
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_autoresize   = true
    disk_size         = var.disk_size_gb
    disk_type         = var.disk_type

    backup_configuration {
      enabled    = var.backup_enabled
      start_time = var.db_backup_window
      location   = var.region
    }

    ip_configuration {
      ipv4_enabled = true
      dynamic "authorized_networks" {
        for_each = [var.custom_static_ip]
        content {
          name  = var.authorized_network_name
          value = authorized_networks.value
        }
      }
    }
    user_labels = {
      name        = "${var.name}-db"
      environment = var.environment
      managed_by  = "terraform"
    }
  }
}

resource "google_sql_user" "default" {
  name     = var.db_username
  instance = google_sql_database_instance.this.name
  password = var.db_password
}

resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.this.name
}
