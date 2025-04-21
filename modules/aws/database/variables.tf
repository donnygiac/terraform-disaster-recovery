variable "name" {
  description = "Prefisso per il nome delle risorse database"
  type        = string
}

variable "vpc_id" {
  description = "ID della VPC AWS"
  type        = string
}

variable "subnet_ids" {
  description = "Lista degli ID delle subnet pubbliche o private"
  type        = list(string)
}

variable "app_sg_id" {
  description = "ID del Security Group delle istanze EC2"
  type        = string
}

variable "custom_static_ip" {
  description = "IP pubblico dell'ufficio per accesso diretto al DB (formato CIDR /32)"
  type        = string
}

variable "db_engine" {
  description = "Motore del database (es. mysql)"
  type        = string
}

variable "db_instance_class" {
  description = "Tipo di istanza RDS (es. db.t3.micro)"
  type        = string
}

variable "db_storage_gb" {
  description = "Storage allocato in GB"
  type        = number
}

variable "db_name" {
  description = "Nome del database"
  type        = string
}

variable "db_identifier" {
  description = "Identificatore univoco per l'istanza RDS"
  type        = string
}

variable "db_username" {
  description = "Username del database"
  type        = string
}

variable "db_password" {
  description = "Password del database"
  type        = string
}

variable "db_backup_retention" {
  description = "Numero di giorni di retention dei backup (0 per disattivare)"
  type        = number
}

variable "db_backup_window" {
  description = "Finestra oraria per i backup (formato hh:mm-hh:mm)"
  type        = string
}