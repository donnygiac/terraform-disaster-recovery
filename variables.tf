# providers.tf - AWS 
variable "aws_region" {
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

# modules/database - AWS
variable "database_primary_name" {
  description = "Prefisso per il nome delle risorse database"
  type        = string
}

variable "database_primary_identifier" {
  description = "Identificatore univoco per l'istanza RDS"
  type        = string
}

variable "database_primary_version" {
  description = "Motore del database (es. mysql)"
  type        = string
}

variable "database_primary_tier" {
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

# modules/google/database
variable "database_secondary_name" {
  description = "Nome risorsa DB GCP"
  type        = string
}

variable "database_secondary_version" {
  description = "Versione del database GCP (es. MYSQL_8_0)"
  type        = string
}

variable "database_secondary_tier" {
  description = "Tier macchina database GCP (es. db-f1-micro)"
  type        = string
}

variable "database_secondary_availability_type" {
  description = "STANDARD o ZONAL"
  type        = string
}

variable "database_secondary_storage" {
  description = "Storage DB in GB"
  type        = number
}

variable "database_secondary_disk_type" {
  description = "Tipo disco: PD_SSD o PD_HDD"
  type        = string
}

variable "database_secondary_backup" {
  description = "Abilitare backup"
  type        = bool
}

variable "database_secondary_db_name" {
  description = "Nome del database"
  type        = string
}

variable "database_secondary_username" {
  description = "Username DB"
  type        = string
}

variable "database_secondary_password" {
  description = "Password DB"
  type        = string
  sensitive   = true
}

variable "authorized_network_name" {
  description = "Nome della rete autorizzata per connettersi al DB (GCP)"
  type        = string
}

# modules/google/load_balancer - GOOGLE
variable "lb_secondary_name" {
  description = "Nome base per il Load Balancer GCP"
  type        = string
}

variable "lb_secondary_instance_group_self_link" {
  description = "Self link del managed instance group GCP"
  type        = string
}

variable "lb_secondary_backend_protocol" {
  description = "Protocollo del backend (es. HTTP)"
  type        = string
}

variable "lb_secondary_backend_port_name" {
  description = "Nome porta del backend (es. http)"
  type        = string
}

variable "lb_secondary_backend_timeout_sec" {
  description = "Timeout del backend in secondi"
  type        = number
}

variable "lb_secondary_enable_cdn" {
  description = "Abilitare CDN per GCP Load Balancer"
  type        = bool
}

# Health Check
variable "lb_secondary_health_path" {
  description = "Percorso per l'health check"
  type        = string
}

variable "lb_secondary_health_port" {
  description = "Porta per l'health check"
  type        = number
}

variable "lb_secondary_health_interval" {
  description = "Intervallo tra i check (in sec)"
  type        = number
}

variable "lb_secondary_health_timeout" {
  description = "Timeout del check (in sec)"
  type        = number
}

variable "lb_secondary_health_healthy_threshold" {
  description = "Check OK richiesti per host sano"
  type        = number
}

variable "lb_secondary_health_unhealthy_threshold" {
  description = "Check falliti per host non sano"
  type        = number
}

# Forwarding Rule
variable "lb_secondary_forwarding_port_range" {
  description = "Range di porte forwarding"
  type        = string
}

variable "lb_secondary_forwarding_ip_protocol" {
  description = "Protocollo IP (TCP/UDP)"
  type        = string
}


## Route 53 - Failover
variable "route53_zone_id" {
  description = "ID della Hosted Zone Route 53"
  type        = string
}

variable "route53_record_name" {
  description = "Nome del record DNS gestito (es. app.miosito.com)"
  type        = string
}

# PRIMARY (AWS)
variable "route53_primary_fqdn" {
  description = "FQDN del servizio primario per l'health check"
  type        = string
}

variable "route53_primary_elb_zone_id" {
  description = "Hosted zone ID del Load Balancer AWS"
  type        = string
}

# Health check config
variable "route53_health_check_path" {
  description = "Percorso da interrogare per l'health check"
  type        = string
}

variable "route53_health_check_type" {
  description = "Tipo di check (es. HTTP, HTTPS)"
  type        = string
}

variable "route53_health_check_interval" {
  description = "Intervallo dei check (secondi)"
  type        = number
}

variable "route53_health_check_failure_threshold" {
  description = "Numero di fallimenti prima di considerare down"
  type        = number
}

variable "route53_evaluate_target_health" {
  description = "Valuta lo stato di salute del target ELB"
  type        = bool
}

variable "route53_secondary_ttl" {
  description = "TTL del record secondario"
  type        = number
}
