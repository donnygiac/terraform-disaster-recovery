variable "name" {
  description = "Nome del Load Balancer"
  type        = string
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
}

variable "target_group_port" {
  description = "Porta target (es. 80 per HTTP)"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocollo per il Target Group (es. HTTP)"
  type        = string
}

variable "listener_port" {
  description = "Porta del listener"
  type        = number
}

variable "listener_protocol" {
  description = "Protocollo del listener"
  type        = string
}

variable "health_check_path" {
  description = "Path per health check"
  type        = string
}

variable "health_check_protocol" {
  description = "Protocollo health check"
  type        = string
}

variable "health_check_matcher" {
  description = "Codice di risposta atteso (es. 200)"
  type        = string
}

variable "health_check_interval" {
  description = "Intervallo tra i check (secondi)"
  type        = number
}

variable "health_check_timeout" {
  description = "Timeout per il health check"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Quanti check per considerare il target sano"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Quanti check per considerare il target NON sano"
  type        = number
}

variable "tags" {
  description = "Mappa di tag da assegnare alle risorse"
  type        = map(string)
}
