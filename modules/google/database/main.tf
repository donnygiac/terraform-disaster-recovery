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
      # Accesso da IP custom statico
      authorized_networks {
        name  = "custom-static-ip"
        value = var.custom_static_ip
      }

      # Accesso dalla VM GCP
      authorized_networks {
        name  = "vm-ip"
        value = var.vm_ip
      }

    }

    user_labels = merge(
      {
        name = "${var.name}-db"
      },
      var.custom_tags
    )
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
