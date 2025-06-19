/*
DECOMMENTA PER USARE I PROVIDER IN PRODUZIONE

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Provider AWS primario
provider "aws" {
  region = var.aws_region
  alias  = "primary"
}

# Provider Google Cloud secondario
provider "google" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
  alias   = "secondary"
}

*/

