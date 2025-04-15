# providers.tf - AWS 
variable "primary_region" {
  description = "Regione AWS per l'ambiente primario"
  type        = string
}

# modules/networking - AWS
variable "vpc_cidr_primary" {
  description = "CIDR block per la VPC"
  type        = string
}

variable "networking_primary_name" {
  description = "Prefisso per il nome delle risorse di rete"
  type        = string
}

variable "subnet_count_primary" {
  description = "Numero di subnet pubbliche da creare"
  type        = number
}

variable "subnet_bits_primary" {
  description = "Numero di bit da usare per derivare il CIDR delle subnet dalla VPC"
  type        = number
}

# modules/compute - AWS
variable "compute_primary_ami" {
  description = "AMI da usare per le istanze EC2 primarie"
  type        = string
}

variable "compute_primary_instance_type" {
  description = "Tipo di istanza EC2 primaria"
  type        = string
}

variable "compute_primary_instance_count" {
  description = "Numero di istanze EC2 da creare"
  type        = number
}

variable "compute_primary_name" {
  description = "Prefisso per il nome delle risorse compute"
  type        = string
}

variable "compute_primary_ingress_rules" {
  description = "Ingress rules per EC2"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "compute_primary_egress_rules" {
  description = "Egress rules per EC2"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# modules/database - AWS
variable "database_primary_name" {
  description = "Prefisso per il nome delle risorse database"
  type        = string
}

variable "database_primary_identifier" {
  description = "Identificatore univoco per l'istanza RDS"
  type        = string
}

variable "database_primary_engine" {
  description = "Motore del database (es. mysql)"
  type        = string
}

variable "database_primary_instance_class" {
  description = "Tipo di istanza RDS (es. db.t3.micro)"
  type        = string
}

variable "database_primary_storage" {
  description = "Storage allocato per il DB (GB)"
  type        = number
}

variable "database_primary_db_name" {
  description = "Nome del database"
  type        = string
}

variable "database_primary_username" {
  description = "Username del database"
  type        = string
}

variable "database_primary_password" {
  description = "Password del database"
  type        = string
  sensitive   = true
}

variable "office_static_ip" {
  description = "IP pubblico (CIDR /32) dell'ufficio per accesso DB"
  type        = string
}


# modules/load_balancer - AWS
variable "lb_primary_name" {
  description = "Nome del Load Balancer primario"
  type        = string
}

variable "lb_primary_internal" {
  description = "LB interno (true) o pubblico (false)"
  type        = bool
}

variable "lb_primary_type" {
  description = "Tipo di LB: application o network"
  type        = string
}

variable "lb_primary_tg_name" {
  description = "Nome del Target Group"
  type        = string
}

variable "lb_primary_tg_port" {
  description = "Porta del Target Group"
  type        = number
}

variable "lb_primary_tg_protocol" {
  description = "Protocollo Target Group (es. HTTP)"
  type        = string
}

variable "lb_primary_listener_port" {
  description = "Porta di ascolto del listener"
  type        = number
}

variable "lb_primary_listener_protocol" {
  description = "Protocollo del listener"
  type        = string
}

variable "lb_primary_health_path" {
  description = "Path per l'health check"
  type        = string
}

variable "lb_primary_health_protocol" {
  description = "Protocollo dell'health check"
  type        = string
}

variable "lb_primary_health_matcher" {
  description = "Codice HTTP di risposta atteso"
  type        = string
}

variable "lb_primary_health_interval" {
  description = "Intervallo in secondi tra i check"
  type        = number
}

variable "lb_primary_health_timeout" {
  description = "Timeout in secondi per ogni check"
  type        = number
}

variable "lb_primary_health_healthy_threshold" {
  description = "Quanti check OK per considerare l’host sano"
  type        = number
}

variable "lb_primary_health_unhealthy_threshold" {
  description = "Quanti check falliti per considerare l’host non sano"
  type        = number
}

variable "lb_primary_tags" {
  description = "Tag da assegnare al Load Balancer"
  type        = map(string)
}

# providers.tf - GOOGLE
variable "google_project" {
  description = "ID del progetto Google Cloud"
  type        = string
}
variable "google_region" {
  description = "Regione per le risorse di Google Cloud"
  type        = string
}
variable "google_zone" {
  description = "Zona Google Cloud"
  type        = string
}

# modules/google/networking - GOOGLE
variable "networking_secondary_firewall_rules" {
  description = "Regole firewall per la rete GCP secondaria"
  type        = list(object({
    name          = string
    protocol      = string
    ports         = list(string)
    direction     = string
    source_ranges = list(string)
    target_tags   = list(string)
  }))
}

variable "networking_secondary_name" {
  description = "Prefisso per le risorse di rete GCP"
  type        = string
}

variable "subnet_cidr_secondary" {
  description = "CIDR della subnet secondaria in GCP"
  type        = string
}

# modules/google/compute - GOOGLE
variable "compute_secondary_name" {
  description = "Prefisso per il nome delle istanze GCP"
  type        = string
}

variable "compute_secondary_instance_count" {
  description = "Numero di istanze GCP da creare"
  type        = number
}

variable "compute_secondary_machine_type" {
  description = "Tipo di macchina GCP (es. e2-micro)"
  type        = string
}

variable "compute_secondary_image" {
  description = "Immagine per il disco boot della VM (es. Debian)"
  type        = string
}

variable "compute_secondary_tags" {
  description = "Lista di tag da associare alla VM (es. per firewall)"
  type        = list(string)
}

variable "compute_secondary_labels" {
  description = "Etichette chiave-valore da associare alla VM"
  type        = map(string)
  default     = {}
}
