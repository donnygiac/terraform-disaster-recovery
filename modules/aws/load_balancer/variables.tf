variable "name" {
  description = "Nome del Load Balancer"
  type        = string
  default     = "primary-alb" # ok default
}

variable "vpc_id" {
  description = "ID della VPC AWS"
  type        = string
}

variable "subnet_ids" {
  description = "Lista degli ID delle subnet"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del Security Group da associare al Load Balancer"
  type        = string
}

variable "instance_ids" {
  description = "Lista degli ID delle istanze EC2 da bilanciare"
  type        = list(string)
}

variable "internal" {
  description = "Indica se il Load Balancer è interno (true) o pubblico (false)"
  type        = bool
}

variable "load_balancer_type" {
  description = "Tipo di Load Balancer (application, network)"
  type        = string
}

variable "target_group_name" {
  description = "Nome del Target Group"
  type        = string
  default     = "primary-tg" # ok default
}

variable "target_group_port" {
  description = "Porta target https"
  type        = number
  default     = 443 # ok default
}

variable "target_group_protocol" {
  description = "Protocollo per il Target Group"
  type        = string
  default     = "HTTPS" # ok default
}

variable "listener_http_port" {
  description = "Porta del listener HTTP"
  type        = number
  default     = 80  # ok default
}

variable "listener_https_port" {
  description = "Porta listener HTTPS"
  type        = number
  default     = 443 # ok default
}

variable "listener_http_protocol" {
  description = "Protocollo del listener HTTP"
  type        = string
  default     = "HTTP"  # ok default
}

variable "listener_https_protocol" {
  description = "Protocollo del listener HTTPS"
  type        = string
  default     = "HTTPS" # ok default
}

variable "health_check_path" {
  description = "Path per health check"
  type        = string
  default     = "/" # ok default
}

variable "health_check_protocol" {
  description = "Protocollo health check"
  type        = string
  default     = "HTTPS" # ok default
}

variable "health_check_matcher" {
  description = "Codice di risposta atteso (es. 200)"
  type        = string
  default     = "200" # ok default
}

variable "health_check_interval" {
  description = "Intervallo tra i check (secondi)"
  type        = number
  default     = 30 # ok default
}

variable "health_check_timeout" {
  description = "Timeout per il health check"
  type        = number
  default     = 5 # ok default
}

variable "health_check_healthy_threshold" {
  description = "Quanti check per considerare il target sano"
  type        = number
  default     = 2 # ok default
}

variable "health_check_unhealthy_threshold" {
  description = "Quanti check per considerare il target NON sano"
  type        = number
  default     = 2 # ok default
}

variable "tags" {
  description = "Mappa di tag da assegnare alle risorse"
  type        = map(string)
}

variable "certificate_arn" {
  description = "ARN del certificato SSL per HTTPS"
  type        = string
}