# Genreric variables for AWS and GCP
variable "database_custom_static_ip" {
  description = "IP pubblico (CIDR /32) dell'ufficio per accesso DB"
  type        = string
}

variable "domain_name" {
  description = "Dominio applicazione"
  type        = string
}

variable "environment" {
  description = "Ambiente di deploy (es. dev, prod)"
  type        = string
}

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

# modules/compute - AWS
variable "compute_primary_name" {
  description = "Prefisso per il nome delle risorse compute"
  type        = string
}

variable "compute_primary_instance_type" {
  description = "Tipo di istanza EC2 primaria"
  type        = string
}

variable "compute_primary_ami" {
  description = "AMI da usare per le istanze EC2 primarie"
  type        = string
}

variable "compute_primary_volume_size" {
  description = "Dimensione del volume root in GB"
  type        = number
}

variable "compute_primary_volume_type" {
  description = "Tipo di volume root (es. gp2, gp3)"
  type        = string
}

variable "compute_primary_ingress_rules" {
  description = "Regole di ingresso per il security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "compute_primary_egress_rules" {
  description = "Regole di uscita per il security group"
  type = list(object({
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

variable "database_primary_backup_retention" {
  description = "Numero di giorni di retention dei backup (0 per disattivare)"
  type        = number
}

variable "database_primary_backup_window" {
  description = "Finestra oraria per i backup (formato hh:mm-hh:mm)"
  type        = string
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

variable "networking_secondary_firewall_rules" {
  description = "Regole firewall per la rete GCP secondaria"
  type = list(object({
    name          = string
    protocol      = string
    ports         = list(string)
    direction     = string
    source_ranges = list(string)
    target_tags   = list(string)
  }))
}

# modules/google/compute - GOOGLE
variable "compute_secondary_name" {
  description = "Prefisso per il nome delle istanze GCP"
  type        = string
}

variable "compute_secondary_machine_type" {
  description = "Tipo di macchina GCP (es. e2-micro)"
  type        = string
}

variable "compute_secondary_image" {
  description = "Immagine per il disco boot della VM (es. Debian)"
  type        = string
}

variable "compute_secondary_disk_size" {
  description = "Dimensione del disco boot in GB"
  type        = number
}

variable "compute_secondary_disk_type" {
  description = "Tipo di disco (es. pd-balanced, pd-ssd, pd-standard)"
  type        = string
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
variable "database_secondary_backup_window" {
  description = "Finestra oraria per i backup (formato hh:mm-hh:mm)"
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

# Health check config
variable "route53_health_check_path" {
  description = "Percorso da interrogare per l'health check"
  type        = string
}

variable "route53_health_check_port" {
  description = "Porta su cui effettuare l'health check"
  type        = number
  default     = 443
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

variable "route53_ttl" {
  description = "TTL del record secondario"
  type        = number
  default     = 60
}
