# Variabili per il modulo AWS Compute
variable "name" {
  description = "Prefisso per il nome delle risorse compute"
  type        = string
}

variable "vpc_id" {
  description = "ID della VPC in cui creare le istanze"
  type        = string
}

variable "subnet_id" {
  description = "Lista degli ID delle subnet pubbliche"
  type        = string
}

variable "instance_type" {
  description = "Tipo di istanza EC2"
  type        = string
}

variable "app_ami" {
  description = "AMI da utilizzare per le istanze EC2"
  type        = string
}

variable "volume_size" {
  description = "Dimensione in GB del volume root"
  type        = number
}

variable "volume_type" {
  description = "Tipo di volume root (es. gp2, gp3)"
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

variable "custom_tags" {
  description = "Tag personalizzati da applicare alle risorse"
  type        = map(string)
}