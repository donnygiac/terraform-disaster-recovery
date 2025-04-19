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

variable "image" {
  description = "Immagine per il disco boot (es. debian)"
  type        = string
}

variable "disk_size" {
  description = "Dimensione del disco boot (GB)"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Tipo di disco (es. pd-balanced, pd-ssd, pd-standard)"
  type        = string
  default     = "pd-balanced"
}


variable "network" {
  description = "Nome della rete VPC GCP"
  type        = string
}

variable "subnetwork" {
  description = "Nome della subnet GCP"
  type        = string
}

variable "labels" {
  description = "Etichette da applicare alla VM"
  type        = map(string)
  default     = {
    environment = "production"
  }
}
