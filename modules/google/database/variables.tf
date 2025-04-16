variable "name" {
  description = "Nome del database (istanza)"
  type        = string
  default     = "secondary-db"
}

variable "region" {
  description = "Regione in cui creare il database"
  type        = string
}

variable "database_version" {
  description = "Versione del motore DB (es. MYSQL_8_0)"
  type        = string
}

variable "tier" {
  description = "Classe della macchina DB (es. db-f1-micro)"
  type        = string
}

variable "availability_type" {
  description = "STANDARD per alta disponibilità, ZONAL per singola zona"
  type        = string
}

variable "disk_size_gb" {
  description = "Dimensione dello storage in GB"
  type        = number
}

variable "disk_type" {
  description = "Tipo disco (PD_SSD o PD_HDD)"
  type        = string
}

variable "backup_enabled" {
  description = "Se abilitare i backup"
  type        = bool
}

variable "allowed_office_ip" {
  description = "IP CIDR dell'ufficio per accesso al DB"
  type        = string
  default     = "203.0.113.10/32"
}

variable "db_name" {
  description = "Nome del database da creare"
  type        = string
}

variable "db_username" {
  description = "Username per il DB"
  type        = string
}

variable "db_password" {
  description = "Password per il DB"
  type        = string
  sensitive   = true
}

variable "authorized_network_name" {
  description = "Nome della rete autorizzata per connettersi al DB"
  type        = string
  default     = "ufficio"
}
