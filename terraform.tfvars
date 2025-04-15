# AWS 
# Settings
primary_region = "us-east-1"

# modules/aws/networking - AWS
networking_primary_name = "primary"
vpc_cidr_primary        = "10.0.0.0/16"
subnet_count_primary    = 2
subnet_bits_primary     = 8

# modules/aws/compute - AWS
compute_primary_ami            = "ami-0123456789abcdef0"
compute_primary_instance_type  = "t2.micro"
compute_primary_instance_count = 2
compute_primary_name           = "primary"
compute_primary_ingress_rules = [
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
    cidr_blocks = ["0.0.0.0/0"]
  }
]

compute_primary_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# modules/aws/database - AWS
database_primary_name           = "primary"
database_primary_identifier     = "primary-db"
database_primary_engine         = "mysql"
database_primary_instance_class = "db.t3.micro"
database_primary_storage        = 20
database_primary_db_name        = "myappdb"
database_primary_username       = "admin"
database_primary_password       = "strongpassword123"
office_static_ip                = "203.0.113.10/32" # IP ufficio modificabile

# modules/aws/load_balancer - AWS
lb_primary_name                       = "primary-alb"
lb_primary_internal                   = false
lb_primary_type                       = "application"
lb_primary_tg_name                    = "primary-tg"
lb_primary_tg_port                    = 80
lb_primary_tg_protocol                = "HTTP"
lb_primary_listener_port              = 80
lb_primary_listener_protocol          = "HTTP"
lb_primary_health_path                = "/"
lb_primary_health_protocol            = "HTTP"
lb_primary_health_matcher             = "200"
lb_primary_health_interval            = 30
lb_primary_health_timeout             = 5
lb_primary_health_healthy_threshold   = 2
lb_primary_health_unhealthy_threshold = 2
lb_primary_tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
}

# Google Cloud Settings
google_project = "my-gcp-project-id" # --> Sostituisci con l'ID reale del tuo progetto
google_region  = "us-central1"
google_zone    = "us-central1-a"


# modules/google/networking - Google Cloud
networking_secondary_name = "secondary"
subnet_cidr_secondary     = "10.1.0.0/16"

networking_secondary_firewall_rules = [
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
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["secondary"]
  }
]

# modules/google/compute - GCP
compute_secondary_name           = "secondary"
compute_secondary_instance_count = 1
compute_secondary_machine_type   = "e2-micro"
compute_secondary_image          = "projects/debian-cloud/global/images/family/debian-10"
compute_secondary_tags           = ["secondary"]

compute_secondary_labels = {
  environment = "dr"
  team        = "infra"
}
