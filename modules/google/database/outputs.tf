output "db_instance_name" {
  description = "Nome dell'istanza DB GCP"
  value       = google_sql_database_instance.this.name
}

output "db_connection_name" {
  description = "Nome completo di connessione al DB"
  value       = google_sql_database_instance.this.connection_name
}
