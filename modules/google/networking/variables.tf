variable "name" {
  description = "Prefisso per le risorse di rete"
  type        = string
  default     = "secondary"
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
  default = [
    {
      name          = "http"
      protocol      = "tcp"
      ports         = ["80"]
      direction     = "INGRESS"
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["secondary"]
    },
    {
      name          = "ssh"
      protocol      = "tcp"
      ports         = ["22"]
      direction     = "INGRESS"
      source_ranges = ["203.0.113.10/32"]
      target_tags   = ["secondary"]
    }
  ]
}
