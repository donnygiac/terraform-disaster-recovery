# AWS 
# Settings
primary_region = "us-east-1"

# modules/aws/networking - AWS
vpc_cidr_primary = "10.0.0.0/16"

# modules/aws/compute - AWS
compute_primary_ami            = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
compute_primary_instance_type  = "t3.micro"
compute_primary_instance_count = 2

# modules/aws/database - AWS
database_primary_engine         = "mysql"
database_primary_instance_class = "db.t3.micro"
database_primary_storage        = 20
database_primary_db_name        = "myappdb"
database_primary_username       = "admin"
database_primary_password       = "MyStr0ngPassw0rd!"
office_static_ip                = "203.0.113.10/32" # IP ufficio modificabile

# modules/aws/load_balancer - AWS
lb_primary_internal                   = false
lb_primary_type                       = "application"
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
subnet_cidr_secondary = "10.1.0.0/16"

# modules/google/compute - Google Cloud
compute_secondary_instance_count = 1
compute_secondary_machine_type   = "e2-micro"
compute_secondary_image          = "projects/debian-cloud/global/images/family/debian-11"

# modules/google/database - Google Cloud
database_secondary_version           = "MYSQL_8_0"
database_secondary_tier              = "db-f1-micro"
database_secondary_availability_type = "ZONAL"
database_secondary_disk_size         = 10
database_secondary_disk_type         = "PD_SSD"
database_secondary_backup            = true
database_secondary_db_name           = "myappdb"
database_secondary_username          = "admin"
database_secondary_password          = "MyStr0ngPassw0rd!"

# GCP Load Balancer
lb_secondary_health_path                = "/"
lb_secondary_health_port                = 80
lb_secondary_health_interval            = 30
lb_secondary_health_timeout             = 5
lb_secondary_health_healthy_threshold   = 2
lb_secondary_health_unhealthy_threshold = 2

# modules/route53_failover - Route53 Failover
# Route53 settings
route53_zone_id             = "Z3P5QSUBK4POTI" # Hosted Zone reale (esempio)
route53_record_name         = "app.example.com"
route53_primary_fqdn        = "app.primary.example.com"
route53_primary_elb_zone_id = "Z35SXDOTRQ7X7K" # Zone ID reale ELB (es. us-east-1)

# Health check settings
route53_health_check_path              = "/"
route53_health_check_type              = "HTTP"
route53_health_check_interval          = 30
route53_health_check_failure_threshold = 3
route53_evaluate_target_health         = true
route53_secondary_ttl                  = 60
