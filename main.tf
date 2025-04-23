#AWS Infrastructure

module "networking_primary" {
  source      = "./modules/aws/networking"
  vpc_cidr    = var.vpc_cidr_primary
  name        = var.networking_primary_name
  environment = var.environment
}

module "compute_primary" {
  source        = "./modules/aws/compute"
  name          = var.compute_primary_name
  vpc_id        = module.networking_primary.vpc_id
  subnet_ids    = module.networking_primary.public_subnets
  instance_type = var.compute_primary_instance_type
  app_ami       = var.compute_primary_ami
  volume_size   = var.compute_primary_volume_size
  volume_type   = var.compute_primary_volume_type
  ingress_rules = var.compute_primary_ingress_rules
  egress_rules  = var.compute_primary_egress_rules
  environment   = var.environment
}

module "database_primary" {
  source              = "./modules/aws/database"
  name                = var.database_primary_name //Prefisso generico usato per nominare risorse Terraform
  vpc_id              = module.networking_primary.vpc_id
  subnet_ids          = module.networking_primary.public_subnets
  app_sg_id           = module.compute_primary.app_sg_id
  custom_static_ip    = var.database_custom_static_ip
  db_identifier       = var.database_primary_identifier
  db_engine           = var.database_primary_version
  db_instance_class   = var.database_primary_tier
  db_storage_gb       = var.database_primary_storage
  db_name             = var.database_primary_db_name // Nome reale del database 
  db_username         = var.database_primary_username
  db_password         = var.database_primary_password
  db_backup_retention = var.database_primary_backup_retention
  db_backup_window    = var.database_primary_backup_window
  environment         = var.environment
}

module "load_balancer_primary" {
  source            = "./modules/aws/load_balancer"
  vpc_id            = module.networking_primary.vpc_id
  subnet_ids        = module.networking_primary.public_subnets
  security_group_id = module.compute_primary.app_sg_id
  instance_ids      = module.compute_primary.instance_ids
  certificate_arn   = var.lb_primary_certificate_arn
  environment       = var.environment

}

# Google Cloud Infrastructure

module "networking_secondary" {
  source         = "./modules/google/networking"
  name           = var.networking_secondary_name
  subnet_cidr    = var.subnet_cidr_secondary
  region         = var.google_region
  firewall_rules = var.networking_secondary_firewall_rules
}

module "compute_secondary" {
  source       = "./modules/google/compute"
  name         = var.compute_secondary_name
  network      = module.networking_secondary.network_name
  subnetwork   = module.networking_secondary.subnetwork_name
  machine_type = var.compute_secondary_machine_type
  zone         = var.google_zone
  region       = var.google_region
  image        = var.compute_secondary_image
  disk_size    = var.compute_secondary_disk_size
  disk_type    = var.compute_secondary_disk_type
  environment  = var.environment
}

module "database_secondary" {
  source            = "./modules/google/database"
  name              = var.database_secondary_name
  region            = var.google_region
  database_version  = var.database_secondary_version
  tier              = var.database_secondary_tier
  availability_type = var.database_secondary_availability_type
  disk_size_gb      = var.database_secondary_storage
  disk_type         = var.database_secondary_disk_type
  backup_enabled    = var.database_secondary_backup
  custom_static_ip  = var.database_custom_static_ip
  db_name           = var.database_secondary_db_name
  db_username       = var.database_secondary_username
  db_password       = var.database_secondary_password
  db_backup_window  = var.database_secondary_backup_window
  environment       = var.environment
}

module "load_balancer_secondary" {
  source        = "./modules/google/load_balancer"
  domain_name   = var.domain_name
  network       = module.networking_secondary.network_name
  subnetwork    = module.networking_secondary.subnetwork_name
  zone          = var.google_zone
  instance_name = module.compute_secondary.instance_name
  instance_ip   = module.compute_secondary.instance_ip
}


# Route 53 Failover DNS Records
module "route53_failover" {
  source                         = "./modules/route53_failover"
  zone_id                        = var.route53_zone_id
  record_name                    = var.domain_name
  primary_fqdn                   = var.domain_name
  primary_elb_dns                = module.load_balancer_primary.forwarding_dns
  primary_elb_zone_id            = module.load_balancer_primary.forwarding_zone_id
  secondary_ip                   = module.load_balancer_secondary.forwarding_ip_address
  health_check_path              = var.route53_health_check_path
  health_check_type              = var.route53_health_check_type
  health_check_interval          = var.route53_health_check_interval
  health_check_failure_threshold = var.route53_health_check_failure_threshold
  evaluate_target_health         = var.route53_evaluate_target_health
  secondary_ttl                  = var.route53_secondary_ttl
  environment                    = var.environment
}
