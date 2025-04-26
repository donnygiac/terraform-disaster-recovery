locals {
  custom_tags = {
    environment = var.environment // Ambiente di deploy (es. dev, prod)
    project     = "example"       // Nome del progetto
    managed_by  = "terraform"     // Indica che la risorsa è gestita da Terraform
  }
}

#AWS Infrastructure
module "networking_primary" {
  source      = "./modules/aws/networking"
  name        = var.networking_primary_name // Nome del modulo
  vpc_cidr    = var.vpc_cidr_primary        // CIDR della VPC
  custom_tags = local.custom_tags           // Tag personalizzati

  providers = {
    aws = aws.primary
  }
}

module "compute_primary" {
  source        = "./modules/aws/compute"
  name          = var.compute_primary_name                   // Nome del modulo
  vpc_id        = module.networking_primary.vpc_id           // ID della VPC
  subnet_id     = module.networking_primary.public_subnet_id // ID delle subnet pubbliche
  instance_type = var.compute_primary_instance_type          // Tipo di istanza EC2 (es. t3.micro)
  app_ami       = var.compute_primary_ami                    // AMI da usare per l'istanza EC2 (es. ami-12345678)
  volume_size   = var.compute_primary_volume_size            // Dimensione del disco in GB (es. 20)
  volume_type   = var.compute_primary_volume_type            // Tipo di volume (es. gp2, gp3, etc.)
  ingress_rules = var.compute_primary_ingress_rules          // Regole di ingresso per il security group (es. HTTP, HTTPS)
  egress_rules  = var.compute_primary_egress_rules           // Regole di uscita per il security group (es. HTTP, HTTPS)
  custom_tags   = local.custom_tags                          // Tag personalizzati

  providers = {
    aws = aws.primary
  }
}

module "database_primary" {
  source              = "./modules/aws/database"
  name                = var.database_primary_name                  //Prefisso generico usato per nominare risorse Terraform
  vpc_id              = module.networking_primary.vpc_id           // ID della VPC
  subnet_id           = module.networking_primary.public_subnet_id // ID delle subnet pubbliche
  app_sg_id           = module.compute_primary.app_sg_id           // ID del security group delle istanze EC2
  custom_static_ip    = var.database_custom_static_ip              // IP statico custom
  db_identifier       = var.database_primary_identifier            // Nome identificativo del database (es. mydb)
  db_engine           = var.database_primary_version               // Tipo di database (es. mysql, postgres, etc.)
  db_instance_class   = var.database_primary_tier                  // Tipo di istanza del database (es. db.t3.micro)
  db_storage_gb       = var.database_primary_storage               // Dimensione del disco in GB
  db_name             = var.database_primary_db_name               // Nome reale del database 
  db_username         = var.database_primary_username              // Nome utente del database
  db_password         = var.database_primary_password              // Password del database
  db_backup_retention = var.database_primary_backup_retention      // 0 per disattivare i backup
  db_backup_window    = var.database_primary_backup_window         // Finestra di backup in formato HH:MM-HH:MM (es. 00:00-02:00)
  custom_tags         = local.custom_tags                          // Tag personalizzati

  providers = {
    aws = aws.primary
  }
}

# Google Cloud Infrastructure
module "networking_secondary" {
  source         = "./modules/google/networking"
  name           = var.networking_secondary_name           // Nome del modulo
  subnet_cidr    = var.subnet_cidr_secondary               // CIDR della subnet secondaria
  region         = var.google_region                       // Regione in cui creare la subnet
  firewall_rules = var.networking_secondary_firewall_rules // Regole firewall da applicare

  providers = {
    google = google.secondary
  }
}

module "compute_secondary" {
  source       = "./modules/google/compute"
  name         = var.compute_secondary_name                  // Nome del modulo
  network      = module.networking_secondary.network_name    // Nome della rete
  subnetwork   = module.networking_secondary.subnetwork_name // Nome della subnet
  machine_type = var.compute_secondary_machine_type          // Tipo di macchina (es. n1-standard-1)
  zone         = var.google_zone                             // Zona in cui creare l'istanza
  region       = var.google_region                           // Regione in cui creare l'istanza
  image        = var.compute_secondary_image                 // Immagine da usare per l'istanza (es. debian-cloud/debian-10)
  disk_size    = var.compute_secondary_disk_size             // Dimensione del disco in GB (es. 10)
  disk_type    = var.compute_secondary_disk_type             // Tipo di disco (es. pd-standard, pd-ssd)
  custom_tags  = local.custom_tags                           // Tag personalizzati

  providers = {
    google = google.secondary
  }
}

module "database_secondary" {
  source            = "./modules/google/database"
  name              = var.database_secondary_name              // Nome del modulo
  region            = var.google_region                        // Regione in cui creare il database
  database_version  = var.database_secondary_version           // Versione del database (es. MYSQL_5_7)
  tier              = var.database_secondary_tier              // Tipo di istanza del database (es. db-f1-micro)
  availability_type = var.database_secondary_availability_type // Tipo di disponibilità (es. ZONAL, REGIONAL)
  disk_size_gb      = var.database_secondary_storage           // Dimensione del disco in GB (es. 10)
  disk_type         = var.database_secondary_disk_type         // Tipo di disco (es. pd-standard, pd-ssd)
  backup_enabled    = var.database_secondary_backup            // Se abilitare i backup
  custom_static_ip  = var.database_custom_static_ip            // IP statico custom
  vm_ip             = module.compute_secondary.instance_ip     // IP pubblico della VM secondaria GCP
  db_name           = var.database_secondary_db_name           // Nome del database da creare
  db_username       = var.database_secondary_username          // Nome utente del database
  db_password       = var.database_secondary_password          // Password del database
  db_backup_window  = var.database_secondary_backup_window     // Finestra di backup in formato HH:MM-HH:MM (es. 00:00-02:00)
  custom_tags       = local.custom_tags                        // Tag personalizzati

  providers = {
    google = google.secondary
  }
}


# Route 53 Failover DNS Records
module "route53_failover" {
  source                         = "./modules/route53_failover"
  zone_id                        = var.route53_zone_id                        // ID della zona Route 53
  record_name                    = var.domain_name                            // Nome del record DNS (es. example.com)
  primary_ip                     = module.compute_primary.public_ip           // IP pubblico dell'istanza primaria
  secondary_ip                   = module.compute_secondary.instance_ip       // IP pubblico dell'istanza secondaria
  health_check_type              = var.route53_health_check_type              // Tipo di controllo di integrità (es. HTTP, HTTPS)
  health_check_port              = var.route53_health_check_port              // Porta per il controllo di integrità (es. 80, 443)
  health_check_path              = var.route53_health_check_path              // Percorso per il controllo di integrità (es. /health)
  health_check_interval          = var.route53_health_check_interval          // Intervallo di controllo di integrità in secondi (es. 30)
  health_check_failure_threshold = var.route53_health_check_failure_threshold // Numero di fallimenti consecutivi per considerare il controllo di integrità fallito
  ttl                            = var.route53_ttl                            // TTL del record DNS in secondi (es. 300)
  custom_tags                    = local.custom_tags                          // Tag personalizzati
}

