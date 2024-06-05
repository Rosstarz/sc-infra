terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "int4t9"
  region      = "europe-west1"
  zone        = "europe-west1-b"
  credentials = file(join("/", [var.project_root, var.gcp_sa_credentials]))
}
