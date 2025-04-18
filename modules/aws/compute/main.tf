# Istanze EC2
resource "aws_instance" "app" {
  count         = var.instance_count
  ami           = var.app_ami
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "${var.name}-app-${count.index + 1}"
  }
}


# Security Group per EC2
resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

