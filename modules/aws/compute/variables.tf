variable "vpc_id" {
  description = "ID della VPC in cui creare le istanze"
  type        = string
}

variable "subnet_ids" {
  description = "Lista degli ID delle subnet pubbliche"
  type        = list(string)
}

variable "app_ami" {
  description = "AMI da utilizzare per le istanze EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo di istanza EC2"
  type        = string
}

variable "instance_count" {
  description = "Numero di istanze EC2 da creare"
  type        = number
}

variable "name" {
  description = "Prefisso per il nome delle risorse compute"
  type        = string
}

variable "ingress_rules" {
  description = "Lista di regole ingress (porta, protocollo, CIDR)"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "Lista di regole egress"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
