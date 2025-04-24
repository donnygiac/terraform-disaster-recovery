variable "zone_id" {
  description = "ID della Hosted Zone di Route 53"
  type        = string
}

variable "record_name" {
  description = "Nome DNS del record (es. app.miosito.com)"
  type        = string
}

# PRIMARY VM (AWS)
variable "primary_ip" {
  description = "IP pubblico della VM primaria (AWS)"
  type        = string
}

# SECONDARY VM (GCP)
variable "secondary_ip" {
  description = "IP pubblico della VM secondaria (GCP)"
  type        = string
}

# Health Check config
variable "health_check_type" {
  description = "Tipo di health check (es. HTTP, HTTPS)"
  type        = string
}

variable "health_check_port" {
  description = "Porta su cui effettuare l'health check"
  type        = number
}

variable "health_check_path" {
  description = "Path usato per l’health check"
  type        = string
}

variable "health_check_interval" {
  description = "Intervallo tra i check (in sec)"
  type        = number
}

variable "health_check_failure_threshold" {
  description = "Numero di fallimenti consecutivi per marcare unhealthy"
  type        = number
}

variable "ttl" {
  description = "TTL del record DNS primario e secondario"
  type        = number
}

variable "custom_tags" {
  description = "Tag personalizzati da applicare alle risorse"
  type        = map(string)
}