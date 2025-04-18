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
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.10/32"]
    }
  ]
}

variable "egress_rules" {
  description = "Lista di regole egress"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}