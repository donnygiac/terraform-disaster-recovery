#AWS Infrastructure

module "networking_primary" {
  source        = "./modules/aws/networking"
  vpc_cidr      = var.vpc_cidr_primary
  name          = var.networking_primary_name
  subnet_count  = var.subnet_count_primary
  subnet_bits   = var.subnet_bits_primary
}

module "compute_primary" {
  source         = "./modules/aws/compute"
  vpc_id         = module.networking_primary.vpc_id
  subnet_ids     = module.networking_primary.public_subnets
  app_ami        = var.compute_primary_ami
  instance_type  = var.compute_primary_instance_type
  instance_count = var.compute_primary_instance_count
  name           = var.compute_primary_name
  ingress_rules  = var.compute_primary_ingress_rules
  egress_rules   = var.compute_primary_egress_rules
}

module "database_primary" {
  source              = "./modules/aws/database"
  name                = var.database_primary_name
  vpc_id              = module.networking_primary.vpc_id
  subnet_ids          = module.networking_primary.public_subnets
  app_sg_id           = module.compute_primary.app_sg_id
  allowed_office_ip   = var.office_static_ip
  db_identifier       = var.database_primary_identifier
  db_engine           = var.database_primary_engine
  db_instance_class   = var.database_primary_instance_class
  db_storage_gb       = var.database_primary_storage
  db_name             = var.database_primary_db_name
  db_username         = var.database_primary_username
  db_password         = var.database_primary_password
}

module "load_balancer_primary" {
  source                = "./modules/aws/load_balancer"
  name                  = var.lb_primary_name
  vpc_id                = module.networking_primary.vpc_id
  subnet_ids            = module.networking_primary.public_subnets
  security_group_id     = module.compute_primary.app_sg_id
  instance_ids          = module.compute_primary.instance_ids
  internal              = var.lb_primary_internal
  load_balancer_type    = var.lb_primary_type
  target_group_name     = var.lb_primary_tg_name
  target_group_port     = var.lb_primary_tg_port
  target_group_protocol = var.lb_primary_tg_protocol
  listener_port         = var.lb_primary_listener_port
  listener_protocol     = var.lb_primary_listener_protocol
  health_check_path     = var.lb_primary_health_path
  health_check_protocol = var.lb_primary_health_protocol
  health_check_matcher  = var.lb_primary_health_matcher
  health_check_interval = var.lb_primary_health_interval
  health_check_timeout  = var.lb_primary_health_timeout
  health_check_healthy_threshold   = var.lb_primary_health_healthy_threshold
  health_check_unhealthy_threshold = var.lb_primary_health_unhealthy_threshold
  tags = var.lb_primary_tags
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
  source         = "./modules/google/compute"
  name           = var.compute_secondary_name
  instance_count = var.compute_secondary_instance_count
  machine_type   = var.compute_secondary_machine_type
  zone           = var.google_zone
  image          = var.compute_secondary_image
  network        = module.networking_secondary.network_name
  subnetwork     = module.networking_secondary.subnetwork_name
  tags           = var.compute_secondary_tags
  labels         = var.compute_secondary_labels
}
