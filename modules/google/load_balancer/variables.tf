variable "name" {
  description = "Nome base per le risorse del Load Balancer"
  type        = string
  default     = "secondary-lb" //ok default
}

variable "domain_name" {
  description = "Dominio da usare per il certificato SSL"
  type        = string
}

variable "backend_protocol" {
  description = "Protocollo per il backend service"
  type        = string
  default     = "HTTP" //ok default
}

variable "backend_port_name" {
  description = "Nome della porta backend (es. http)"
  type        = string
  default     = "http" //ok default
}

variable "backend_timeout_sec" {
  description = "Timeout in secondi del backend"
  type        = number
  default     = 10 //ok default
}

# Health check
variable "health_check_path" {
  description = "Path per l'health check"
  type        = string
  default     = "/" //ok default
}

variable "health_check_port" {
  description = "Porta da usare per l'health check"
  type        = number
  default     = 443 //ok default
}

variable "health_check_interval" {
  description = "Intervallo tra health check (secondi)"
  type        = number
  default     = 30 //ok default
}

variable "health_check_timeout" {
  description = "Timeout del health check (secondi)"
  type        = number
  default     = 5 //ok default
}

variable "health_check_healthy_threshold" {
  description = "Numero di successi per considerare sano"
  type        = number
  default     = 2 //ok default
}

variable "health_check_unhealthy_threshold" {
  description = "Numero di fallimenti per considerare non sano"
  type        = number
  default     = 2 //ok default
}

# Forwarding rules
variable "forwarding_http_port_range" {
  description = "Porta di forwarding per HTTP"
  type        = string
  default     = "80" //ok default
}

variable "forwarding_https_port_range" {
  description = "Porta di forwarding per HTTPS"
  type        = string
  default     = "443" //ok default
}

variable "forwarding_ip_protocol" {
  description = "Protocollo IP da usare per il forwarding (es. TCP)"
  type        = string
  default     = "TCP" //ok default
}


//
variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "zone" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_ip" {
  type = string
}

variable "backend_port" {
  type    = number
  default = 443
}
