# AWS 
# Settings
primary_region = "us-east-1"

# modules/aws/networking - AWS
networking_primary_name = "primary"
vpc_cidr_primary        = "10.0.0.0/16"
subnet_count_primary    = 2
subnet_bits_primary     = 8

# modules/aws/compute - AWS
compute_primary_ami            = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
compute_primary_instance_type  = "t3.micro"
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
    cidr_blocks = ["203.0.113.10/32"] # solo IP ufficio
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
database_primary_password       = "MyStr0ngPassw0rd!"
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
  Environment = "production"
  ManagedBy   = "Terraform"
}

# Google Cloud Settings
google_project = "my-real-gcp-project"
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
    source_ranges = ["203.0.113.10/32"] # solo IP ufficio
    target_tags   = ["secondary"]
  }
]

# modules/google/compute - Google Cloud
compute_secondary_name           = "secondary"
compute_secondary_instance_count = 1
compute_secondary_machine_type   = "e2-micro"
compute_secondary_image          = "projects/debian-cloud/global/images/family/debian-11"
compute_secondary_tags           = ["secondary"]

compute_secondary_labels = {
  environment = "dr"
  team        = "infra"
}

# modules/google/database - Google Cloud
database_secondary_name              = "secondary-db"
database_secondary_version           = "MYSQL_8_0"
database_secondary_tier              = "db-f1-micro"
database_secondary_availability_type = "ZONAL"
database_secondary_disk_size         = 10
database_secondary_disk_type         = "PD_SSD"
database_secondary_backup            = true
database_secondary_db_name           = "myappdb"
database_secondary_username          = "admin"
database_secondary_password          = "MyStr0ngPassw0rd!"
authorized_network_name              = "ufficio"

# GCP Load Balancer
lb_secondary_name                     = "secondary-lb"
lb_secondary_instance_group_self_link = "projects/my-real-gcp-project/zones/us-central1-a/instanceGroups/secondary-group"

lb_secondary_backend_protocol    = "HTTP"
lb_secondary_backend_port_name   = "http"
lb_secondary_backend_timeout_sec = 10
lb_secondary_enable_cdn          = false

lb_secondary_health_path                = "/"
lb_secondary_health_port                = 80
lb_secondary_health_interval            = 30
lb_secondary_health_timeout             = 5
lb_secondary_health_healthy_threshold   = 2
lb_secondary_health_unhealthy_threshold = 2

lb_secondary_forwarding_port_range  = "80"
lb_secondary_forwarding_ip_protocol = "TCP"

# modules/route53_failover - Route53 Failover
# Route53 settings
route53_zone_id                   = "Z3P5QSUBK4POTI"               # Hosted Zone reale (esempio)
route53_record_name               = "app.example.com"
route53_primary_fqdn              = "app.primary.example.com"
route53_primary_elb_zone_id       = "Z35SXDOTRQ7X7K"              # Zone ID reale ELB (es. us-east-1)

# Health check settings
route53_health_check_path              = "/"
route53_health_check_type              = "HTTP"
route53_health_check_interval          = 30
route53_health_check_failure_threshold = 3

route53_evaluate_target_health = true
route53_secondary_ttl          = 60
