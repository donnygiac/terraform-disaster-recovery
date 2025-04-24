variable "name" {
  description = "Prefisso per il nome dell'istanza"
  type        = string
}

variable "machine_type" {
  description = "Tipo di macchina GCP (es. e2-micro)"
  type        = string
}

variable "zone" {
  description = "Zona della VM"
  type        = string
}

variable "region" {
  description = "Regione GCP"
  type        = string
}

variable "image" {
  description = "Immagine per il disco boot (es. debian)"
  type        = string
}

variable "disk_size" {
  description = "Dimensione del disco boot (GB)"
  type        = number
}

variable "disk_type" {
  description = "Tipo di disco (es. pd-balanced, pd-ssd, pd-standard)"
  type        = string
}


variable "network" {
  description = "Nome della rete VPC GCP"
  type        = string
}

variable "subnetwork" {
  description = "Nome della subnet GCP"
  type        = string
}

variable "custom_tags" {
  description = "Tag personalizzati per l'istanza"
  type        = map(string)
}