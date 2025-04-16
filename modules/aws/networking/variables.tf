variable "vpc_cidr" {
  description = "CIDR block per la VPC"
  type        = string
}

variable "name" {
  description = "Prefisso per il nome delle risorse di rete"
  type        = string
  default     = "primary"
}

variable "subnet_count" {
  description = "Numero di subnet pubbliche da creare"
  type        = number
  default     = 2
}

variable "subnet_bits" {
  description = "Numero di bit da usare per derivare il CIDR delle subnet dalla VPC"
  type        = number
  default     = 8
}