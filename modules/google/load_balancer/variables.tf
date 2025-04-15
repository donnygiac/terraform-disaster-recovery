variable "name" {
  description = "Nome base per tutte le risorse del LB"
  type        = string
}

variable "instance_group_self_link" {
  description = "Self link dell'instance group da bilanciare"
  type        = string
}

# Backend Service
variable "backend_protocol" {
  description = "Protocollo per il backend service"
  type        = string
  default     = "HTTP"
}

variable "backend_port_name" {
  description = "Nome della porta backend (es. http)"
  type        = string
  default     = "http"
}

variable "backend_timeout_sec" {
  description = "Timeout in secondi del backend"
  type        = number
  default     = 10
}

variable "enable_cdn" {
  description = "Abilitare Google Cloud CDN"
  type        = bool
  default     = false
}

# Health check
variable "health_check_path" {
  description = "Percorso dell'health check"
  type        = string
}

variable "health_check_port" {
  description = "Porta da usare per l'health check"
  type        = number
}

variable "health_check_interval" {
  description = "Intervallo tra health check (in sec)"
  type        = number
}

variable "health_check_timeout" {
  description = "Timeout health check (in sec)"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Check OK necessari per host sano"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Check falliti per marcare host non sano"
  type        = number
}

# Forwarding rule
variable "forwarding_port_range" {
  description = "Range di porte (es. 80)"
  type        = string
  default     = "80"
}

variable "forwarding_ip_protocol" {
  description = "Protocollo IP (TCP/UDP)"
  type        = string
  default     = "TCP"
}
