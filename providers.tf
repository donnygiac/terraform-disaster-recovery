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

# Provider AWS primario (mock)
provider "aws" {
  region                      = var.aws_region
  alias                       = "primary"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

# Provider Google Cloud secondario (mock)
provider "google" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
  alias   = "secondary"
  credentials = jsonencode({
    type                        = "service_account"
    project_id                  = "mock_project"
    private_key_id              = "mock_key_id"
    private_key                 = "mock_private_key"
    client_email                = "mock@example.com"
    client_id                   = "mock_client_id"
    auth_uri                    = "https://accounts.google.com/o/oauth2/auth"
    token_uri                   = "https://oauth2.googleapis.com/token"
    auth_provider_x509_cert_url = "https://www.googleapis.com/oauth2/v1/certs"
    client_x509_cert_url        = "https://www.googleapis.com/robot/v1/metadata/x509/mock@example.com"
  })
}
