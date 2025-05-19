variable "vpc_cidr" {
  description = "CIDR block per la VPC"
  type        = string
}

variable "name" {
  description = "Prefisso per il nome delle risorse di rete"
  type        = string
}

variable "custom_tags" {
  description = "Tags personalizzati da applicare alle risorse"
  type        = map(string)
}

variable "aws_zone" {
  description = "Zona AWS in cui creare le risorse"
  type        = string
}