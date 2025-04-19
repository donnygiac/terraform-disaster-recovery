variable "vpc_cidr" {
  description = "CIDR block per la VPC"
  type        = string
}

variable "name" {
  description = "Prefisso per il nome delle risorse di rete"
  type        = string
  default     = "primary"
}