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
      enabled = var.backup_enabled
    }

    ip_configuration {
      ipv4_enabled = true
      dynamic "authorized_networks" {
        for_each = [var.allowed_office_ip]
        content {
          name = var.authorized_network_name
          value = authorized_networks.value
        }
      }
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
