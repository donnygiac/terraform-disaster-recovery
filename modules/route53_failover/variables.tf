variable "zone_id" {
  description = "ID della Hosted Zone di Route 53"
  type        = string
}

variable "record_name" {
  description = "Nome DNS del record (es. app.miosito.com)"
  type        = string
}

# PRIMARY (AWS)
variable "primary_fqdn" {
  description = "FQDN per il controllo di health check (es. app.primary.miosito.com)"
  type        = string
}

variable "primary_elb_dns" {
  description = "DNS del load balancer primario (AWS)"
  type        = string
}

variable "primary_elb_zone_id" {
  description = "Hosted zone ID del load balancer primario"
  type        = string
}

# SECONDARY (GCP)
variable "secondary_ip" {
  description = "IP pubblico dell'infrastruttura secondaria (GCP)"
  type        = string
}

# Health Check config
variable "health_check_path" {
  description = "Path usato per l’health check"
  type        = string
}

variable "health_check_type" {
  description = "Tipo di health check (es. HTTP, HTTPS)"
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

variable "evaluate_target_health" {
  description = "Se true, Route53 valuta la salute del target ELB"
  type        = bool
  default     = true
}

# Record SECONDARY
variable "secondary_ttl" {
  description = "TTL del record DNS secondario"
  type        = number
  default     = 60
}
