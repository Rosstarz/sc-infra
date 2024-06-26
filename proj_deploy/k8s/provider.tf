terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.32.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
}

# Retrieve GKE cluster information
provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(join("/", [var.project_root, var.gcp_sa_credentials]))
}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = "${var.project_name}-gke"
  location = var.zone
}

data "google_sql_database_instance" "main" {
  name = "db1"
}

provider "kubernetes" {
  host = "https://${data.google_container_cluster.primary.endpoint}"

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}
