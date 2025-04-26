database_custom_static_ip = "203.0.113.10/32" # IP statico custom di accesso
domain_name               = "app.example.com"
environment               = "production" # Ambiente di deploy (es. dev, prod)

## AWS
aws_region = "us-west-1"
## Google Cloud
google_project = "my-real-gcp-project"
google_region  = "europe-west1"
google_zone    = "europe-west1-b"

# NETWORKING SETTINGS
## modules/aws/networking - AWS
networking_primary_name = "primary-vpc"
vpc_cidr_primary        = "10.0.0.0/16"
## modules/google/networking - Google Cloud
networking_secondary_name = "secondary-vpc"
subnet_cidr_secondary     = "10.1.0.0/16"
networking_secondary_firewall_rules = [
  {
    name          = "http"
    protocol      = "tcp"
    ports         = ["80"]
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["secondary-vm-name-app"]
  },
  {
    name          = "https"
    protocol      = "tcp"
    ports         = ["443"]
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["secondary-vm-name-app"]
  },
  {
    name          = "ssh"
    protocol      = "tcp"
    ports         = ["22"]
    direction     = "INGRESS"
    source_ranges = ["203.0.113.10/32"] # IP statico custom
    target_tags   = ["secondary-vm-name-app"]
  }
]

# COMPUTE SETTINGS
## modules/aws/compute - AWS
compute_primary_name          = "primary-vm-name"
compute_primary_instance_type = "t3.medium"
compute_primary_ami           = "ami-09454961f90c7c88c"
compute_primary_volume_size   = 60
compute_primary_volume_type   = "gp3"
compute_primary_ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.10/32"] # IP ufficio modificabile
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

## modules/google/compute - Google Cloud
compute_secondary_name         = "secondary-vm-name"
compute_secondary_machine_type = "e2-standard-2"
compute_secondary_image        = "projects/debian-cloud/global/images/family/debian-12"
compute_secondary_disk_size    = 60
compute_secondary_disk_type    = "pd-balanced"

# DATABASE SETTINGS
## modules/aws/database - AWS
database_primary_name             = "primary-db-name"
database_primary_identifier       = "primary-db-identifier"
database_primary_version          = "mysql"
database_primary_tier             = "db.t3.medium"
database_primary_storage          = 20
database_primary_db_name          = "myappdb"
database_primary_username         = "admin"
database_primary_password         = "MyStr0ngPassw0rd!"
database_primary_backup_retention = 7             # (0 per disattivare)
database_primary_backup_window    = "03:00-04:00" # (formato hh:mm-hh:mm)
## modules/google/database - Google Cloud
database_secondary_name              = "secondary-db-name"
database_secondary_version           = "MYSQL_8_0"
database_secondary_tier              = "db-custom-2-4096"
database_secondary_availability_type = "ZONAL"
database_secondary_storage           = 20
database_secondary_disk_type         = "PD_SSD"
database_secondary_backup            = true
database_secondary_db_name           = "myappdb"
database_secondary_username          = "admin"
database_secondary_password          = "MyStr0ngPassw0rd!"
database_secondary_backup_window     = "03:00" # (formato hh:mm)

# FAILOVER SETTINGS
## modules/route53_failover - Route53 Failover
### Route53 settings
route53_zone_id = "Z3P5QSUBK4POTI" # Deve esistere in AWS        # Deve esistere in AWS
