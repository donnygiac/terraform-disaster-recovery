# Istanza RDS
resource "aws_db_instance" "this" {
  identifier             = var.db_identifier
  engine                 = var.db_engine
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_storage_gb
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true

  # Backup config
  backup_retention_period = var.db_backup_retention
  backup_window           = var.db_backup_window


  tags = merge(
    {
      name = "${var.name}-rds"
    },
    var.custom_tags
  )
}

# Gruppo di subnet per RDS
resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_id


  tags = merge(
    {
      name = "${var.name}-subnet-group"
    },
    var.custom_tags
  )
}

# Security Group per RDS
resource "aws_security_group" "rds_sg" {
  name   = "${var.name}-rds-sg"
  vpc_id = var.vpc_id

  # Accesso dalle EC2 (tramite SG)
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.app_sg_id]
    description     = "Accesso dalle istanze EC2"
  }

  # Accesso diretto IP custom
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.custom_static_ip]
    description = "Accesso diretto da ip"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      name = "${var.name}-rds-sg"
    },
    var.custom_tags
  )
}