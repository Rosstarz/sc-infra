terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.32.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(join("/", [var.project_root, var.gcp_sa_credentials]))
}
