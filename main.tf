locals {
  custom_tags = {
    environment = var.environment //ok // Ambiente di deploy (es. dev, prod)
    project     = "example"       //ok // Nome del progetto
    managed_by  = "terraform"     //ok // Indica che la risorsa è gestita da Terraform
  }
}

#AWS Infrastructure
module "networking_primary" {
  source      = "./modules/aws/networking"
  name        = var.networking_primary_name //ok // Nome del modulo
  vpc_cidr    = var.vpc_cidr_primary        //ok // CIDR della VPC
  custom_tags = local.custom_tags           //ok // Tag personalizzati
}

module "compute_primary" {
  source        = "./modules/aws/compute"
  name          = var.compute_primary_name                 //ok // Nome del modulo
  vpc_id        = module.networking_primary.vpc_id         //ok // ID della VPC
  subnet_ids    = module.networking_primary.public_subnets //ok // ID delle subnet pubbliche
  instance_type = var.compute_primary_instance_type        //ok // Tipo di istanza EC2 (es. t3.micro)
  app_ami       = var.compute_primary_ami                  //ok  // AMI da usare per l'istanza EC2 (es. ami-12345678)
  volume_size   = var.compute_primary_volume_size          //ok // Dimensione del disco in GB (es. 20)
  volume_type   = var.compute_primary_volume_type          //ok // Tipo di volume (es. gp2, gp3, etc.)
  ingress_rules = var.compute_primary_ingress_rules        //ok // Regole di ingresso per il security group (es. HTTP, HTTPS)
  egress_rules  = var.compute_primary_egress_rules         //ok // Regole di uscita per il security group (es. HTTP, HTTPS)
  custom_tags   = local.custom_tags                        //ok // Tag personalizzati
}

module "database_primary" {
  source              = "./modules/aws/database"
  name                = var.database_primary_name                //ok //Prefisso generico usato per nominare risorse Terraform
  vpc_id              = module.networking_primary.vpc_id         //ok // ID della VPC
  subnet_ids          = module.networking_primary.public_subnets //ok // ID delle subnet pubbliche
  app_sg_id           = module.compute_primary.app_sg_id         //ok // ID del security group delle istanze EC2
  custom_static_ip    = var.database_custom_static_ip            //ok // IP statico custom
  db_identifier       = var.database_primary_identifier          //ok // Nome identificativo del database (es. mydb)
  db_engine           = var.database_primary_version             //ok // Tipo di database (es. mysql, postgres, etc.)
  db_instance_class   = var.database_primary_tier                //ok // Tipo di istanza del database (es. db.t3.micro)
  db_storage_gb       = var.database_primary_storage             //ok // Dimensione del disco in GB
  db_name             = var.database_primary_db_name             //ok // Nome reale del database 
  db_username         = var.database_primary_username            //ok // Nome utente del database
  db_password         = var.database_primary_password            //ok // Password del database
  db_backup_retention = var.database_primary_backup_retention    //ok // 0 per disattivare i backup
  db_backup_window    = var.database_primary_backup_window       //ok // Finestra di backup in formato HH:MM-HH:MM (es. 00:00-02:00)
  custom_tags         = local.custom_tags                        //ok // Tag personalizzati
}

# Google Cloud Infrastructure
module "networking_secondary" {
  source         = "./modules/google/networking"
  name           = var.networking_secondary_name           //ok // Nome del modulo
  subnet_cidr    = var.subnet_cidr_secondary               //ok // CIDR della subnet secondaria
  region         = var.google_region                       //ok // Regione in cui creare la subnet
  firewall_rules = var.networking_secondary_firewall_rules //ok // Regole firewall da applicare
}

module "compute_secondary" {
  source       = "./modules/google/compute"
  name         = var.compute_secondary_name                  //ok // Nome del modulo
  network      = module.networking_secondary.network_name    //ok // Nome della rete
  subnetwork   = module.networking_secondary.subnetwork_name //ok // Nome della subnet
  machine_type = var.compute_secondary_machine_type          //ok // Tipo di macchina (es. n1-standard-1)
  zone         = var.google_zone                             //ok // Zona in cui creare l'istanza
  region       = var.google_region                           //ok // Regione in cui creare l'istanza
  image        = var.compute_secondary_image                 //ok // Immagine da usare per l'istanza (es. debian-cloud/debian-10)
  disk_size    = var.compute_secondary_disk_size             //ok // Dimensione del disco in GB (es. 10)
  disk_type    = var.compute_secondary_disk_type             //ok // Tipo di disco (es. pd-standard, pd-ssd)
  custom_tags  = local.custom_tags                           //ok // Tag personalizzati
}

module "database_secondary" {
  source            = "./modules/google/database"
  name              = var.database_secondary_name              //ok // Nome del modulo
  region            = var.google_region                        //ok // Regione in cui creare il database
  database_version  = var.database_secondary_version           //ok // Versione del database (es. MYSQL_5_7)
  tier              = var.database_secondary_tier              //ok // Tipo di istanza del database (es. db-f1-micro)
  availability_type = var.database_secondary_availability_type //ok // Tipo di disponibilità (es. ZONAL, REGIONAL)
  disk_size_gb      = var.database_secondary_storage           //ok // Dimensione del disco in GB (es. 10)
  disk_type         = var.database_secondary_disk_type         //ok // Tipo di disco (es. pd-standard, pd-ssd)
  backup_enabled    = var.database_secondary_backup            //ok // Se abilitare i backup
  custom_static_ip  = var.database_custom_static_ip            //ok // IP statico custom
  vm_ip             = module.compute_secondary.instance_ip     //ok // IP pubblico della VM secondaria GCP
  db_name           = var.database_secondary_db_name           //ok // Nome del database da creare
  db_username       = var.database_secondary_username          //ok // Nome utente del database
  db_password       = var.database_secondary_password          //ok // Password del database
  db_backup_window  = var.database_secondary_backup_window     //ok // Finestra di backup in formato HH:MM-HH:MM (es. 00:00-02:00)
  custom_tags       = local.custom_tags                        //ok // Tag personalizzati
}


# Route 53 Failover DNS Records
module "route53_failover" {
  source                         = "./modules/route53_failover"
  zone_id                        = var.route53_zone_id
  record_name                    = var.domain_name
  primary_ip                     = module.compute_primary.public_ip
  secondary_ip                   = module.compute_secondary.instance_ip
  health_check_type              = var.route53_health_check_type
  health_check_port              = var.route53_health_check_port
  health_check_path              = var.route53_health_check_path
  health_check_interval          = var.route53_health_check_interval
  health_check_failure_threshold = var.route53_health_check_failure_threshold
  ttl                            = var.route53_ttl
  custom_tags                    = local.custom_tags
}

