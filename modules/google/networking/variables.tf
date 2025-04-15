variable "name" {
  description = "Prefisso per le risorse di rete"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR per la subnet"
  type        = string
}

variable "region" {
  description = "Regione in cui creare la subnet"
  type        = string
}

variable "firewall_rules" {
  description = "Lista di regole firewall da creare"
  type = list(object({
    name          = string
    protocol      = string
    ports         = list(string)
    direction     = string
    source_ranges = list(string)
    target_tags   = list(string)
  }))
}
