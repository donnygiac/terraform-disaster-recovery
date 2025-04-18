# GENERAL SETTINGS
office_static_ip = "203.0.113.10/32" # IP ufficio modificabile
## AWS
aws_region = "us-west-1"
## Google Cloud
google_project = "my-real-gcp-project"
google_region  = "europe-west1"
google_zone    = "europe-west1-b"

# NETWORKING SETTINGS
## modules/aws/networking - AWS
vpc_cidr_primary = "10.0.0.0/16"
networking_primary_name = "primary-vpc"
subnet_count_primary = 2
subnet_bits_primary = 8
## modules/google/networking - Google Cloud
subnet_cidr_secondary = "10.1.0.0/16"
networking_secondary_name = "secondary-vpc"

# COMPUTE SETTINGS
## modules/aws/compute - AWS
compute_primary_name            = "primary-vm-name"
compute_primary_instance_count = 1
compute_primary_ami            = "ami-09454961f90c7c88c"
compute_primary_instance_type  = "t3.medium"
## modules/google/compute - Google Cloud
compute_secondary_name            = "secondary-vm-name"
compute_secondary_instance_count = 1
compute_secondary_machine_type   = "e2-standard-2"
compute_secondary_image          = "projects/debian-cloud/global/images/family/debian-12"

# DATABASE SETTINGS
## modules/aws/database - AWS
database_primary_name = "primary-db-name"
database_primary_identifier = "primary-db-identifier"
database_primary_version  = "mysql"
database_primary_tier     = "db.t3.medium"
database_primary_storage  = 20
database_primary_db_name  = "myappdb"
database_primary_username = "admin"
database_primary_password = "MyStr0ngPassw0rd!"
## modules/google/database - Google Cloud
database_secondary_version           = "MYSQL_8_0"
database_secondary_tier              = "db-custom-2-4096"
database_secondary_availability_type = "ZONAL"
database_secondary_storage           = 20
database_secondary_disk_type         = "PD_SSD"
database_secondary_backup            = true
database_secondary_db_name           = "myappdb"
database_secondary_username          = "admin"
database_secondary_password          = "MyStr0ngPassw0rd!"

# LOAD BALANCER SETTINGS
## modules/aws/load_balancer - AWS
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
## modules/google/load_balancer - Google Cloud
lb_secondary_health_path                = "/"
lb_secondary_health_port                = 80
lb_secondary_health_interval            = 30
lb_secondary_health_timeout             = 5
lb_secondary_health_healthy_threshold   = 2
lb_secondary_health_unhealthy_threshold = 2

# FAILOVER SETTINGS
## modules/route53_failover - Route53 Failover
### Route53 settings
route53_zone_id      = "Z3P5QSUBK4POTI"          # Deve esistere in AWS
route53_record_name  = "app.example.com"         # Deve esistere in AWS
route53_primary_fqdn = "app.primary.example.com" # Deve esistere in AWS
### Health check settings
route53_health_check_path              = "/"
route53_health_check_type              = "HTTP"
route53_health_check_interval          = 30
route53_health_check_failure_threshold = 3
route53_evaluate_target_health         = true
route53_secondary_ttl                  = 60
