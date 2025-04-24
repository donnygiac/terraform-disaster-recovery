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
  region                      = var.aws_region
  alias                       = "primary"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

# Provider Google Cloud secondario
provider "google" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
  alias   = "secondary"
}
