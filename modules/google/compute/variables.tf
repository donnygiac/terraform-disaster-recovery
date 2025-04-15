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

variable "instance_count" {
  description = "Numero di istanze da creare"
  type        = number
}

variable "network" {
  description = "Nome della rete VPC GCP"
  type        = string
}

variable "subnetwork" {
  description = "Nome della subnet GCP"
  type        = string
}

variable "tags" {
  description = "Lista di tag per le istanze (per firewall)"
  type        = list(string)
}

variable "labels" {
  description = "Etichette da applicare alla VM"
  type        = map(string)
  default     = {}
}
