variable "name" {
  description = "Nome del database (istanza)"
  type        = string
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

variable "custom_static_ip" {
  description = "IP CIDR dell'ufficio per accesso al DB"
  type        = string
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

variable "vm_ip" {
  description = "IP pubblico della VM secondaria GCP"
  type        = string
}

variable "db_backup_window" {
  description = "Finestra di backup del DB"
  type        = string  
}

variable "custom_tags" {
  description = "Tag personalizzati da applicare al DB"
  type        = map(string)
}

