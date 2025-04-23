#AWS Infrastructure

module "networking_primary" {
  source      = "./modules/aws/networking"
  vpc_cidr    = var.vpc_cidr_primary        //ok
  name        = var.networking_primary_name //ok
  environment = var.environment             //ok
}

module "compute_primary" {
  source        = "./modules/aws/compute"
  name          = var.compute_primary_name //ok
  vpc_id        = module.networking_primary.vpc_id
  subnet_ids    = module.networking_primary.public_subnets
  instance_type = var.compute_primary_instance_type //ok
  app_ami       = var.compute_primary_ami           //ok
  volume_size   = var.compute_primary_volume_size   //ok
  volume_type   = var.compute_primary_volume_type   //ok
  ingress_rules = var.compute_primary_ingress_rules //ok
  egress_rules  = var.compute_primary_egress_rules  //ok
  environment   = var.environment                   //ok
}

module "database_primary" {
  source              = "./modules/aws/database"
  name                = var.database_primary_name //ok //Prefisso generico usato per nominare risorse Terraform
  vpc_id              = module.networking_primary.vpc_id
  subnet_ids          = module.networking_primary.public_subnets
  app_sg_id           = module.compute_primary.app_sg_id
  custom_static_ip    = var.database_custom_static_ip
  db_identifier       = var.database_primary_identifier       //ok
  db_engine           = var.database_primary_version          //ok
  db_instance_class   = var.database_primary_tier             //ok
  db_storage_gb       = var.database_primary_storage          //ok
  db_name             = var.database_primary_db_name          //ok // Nome reale del database 
  db_username         = var.database_primary_username         //ok
  db_password         = var.database_primary_password         //ok
  db_backup_retention = var.database_primary_backup_retention //ok
  db_backup_window    = var.database_primary_backup_window    //ok
  environment         = var.environment                       //ok
}

module "load_balancer_primary" {
  source            = "./modules/aws/load_balancer"
  vpc_id            = module.networking_primary.vpc_id
  subnet_ids        = module.networking_primary.public_subnets
  security_group_id = module.compute_primary.app_sg_id
  instance_ids      = module.compute_primary.instance_ids
  certificate_arn   = var.lb_primary_certificate_arn //ok
  environment       = var.environment                //ok
}

# Google Cloud Infrastructure

module "networking_secondary" {
  source         = "./modules/google/networking"
  name           = var.networking_secondary_name           //ok
  subnet_cidr    = var.subnet_cidr_secondary               //ok
  region         = var.google_region                       //ok
  firewall_rules = var.networking_secondary_firewall_rules //ok
}

module "compute_secondary" {
  source       = "./modules/google/compute"
  name         = var.compute_secondary_name //ok
  network      = module.networking_secondary.network_name
  subnetwork   = module.networking_secondary.subnetwork_name
  machine_type = var.compute_secondary_machine_type //ok
  zone         = var.google_zone                    //ok
  region       = var.google_region                  //ok
  image        = var.compute_secondary_image        //ok
  disk_size    = var.compute_secondary_disk_size    //ok
  disk_type    = var.compute_secondary_disk_type    //ok
  environment  = var.environment                    //ok
}

module "database_secondary" {
  source            = "./modules/google/database"
  name              = var.database_secondary_name              //ok
  region            = var.google_region                        //ok
  database_version  = var.database_secondary_version           //ok
  tier              = var.database_secondary_tier              //ok
  availability_type = var.database_secondary_availability_type //ok
  disk_size_gb      = var.database_secondary_storage           //ok
  disk_type         = var.database_secondary_disk_type         //ok
  backup_enabled    = var.database_secondary_backup            //ok
  custom_static_ip  = var.database_custom_static_ip            //ok
  db_name           = var.database_secondary_db_name           //ok
  db_username       = var.database_secondary_username          //ok
  db_password       = var.database_secondary_password          //ok 
  db_backup_window  = var.database_secondary_backup_window     //ok
  environment       = var.environment                          //ok
}

module "load_balancer_secondary" {
  source                   = "./modules/google/load_balancer"
  instance_group_self_link = module.compute_secondary.instance_group_self_link //ok
  domain_name              = var.domain_name                                   //ok
}


# Route 53 Failover DNS Records
module "route53_failover" {
  source                         = "./modules/route53_failover"
  zone_id                        = var.route53_zone_id      //ok
  record_name                    = var.domain_name  //ok
  primary_fqdn                   = var.domain_name //ok
  primary_elb_dns                = module.load_balancer_primary.forwarding_dns
  primary_elb_zone_id            = module.load_balancer_primary.forwarding_zone_id
  secondary_ip                   = module.compute_secondary.instance_ip
  health_check_path              = var.route53_health_check_path              //ok
  health_check_type              = var.route53_health_check_type              //ok
  health_check_interval          = var.route53_health_check_interval          //ok
  health_check_failure_threshold = var.route53_health_check_failure_threshold //ok
  evaluate_target_health         = var.route53_evaluate_target_health         //ok
  secondary_ttl                  = var.route53_secondary_ttl                  //ok
  environment                    = var.environment                            //ok
}
