resource "google_sql_database_instance" "main" {
  name             = "db1"
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_type         = "PD_HDD"
    disk_size         = 10

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc.id
      enable_private_path_for_google_cloud_services = true
    }
  }

  # deletion_protection = "true"

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_user" "users" {
  name     = var.postgres_user
  instance = google_sql_database_instance.main.name
  password = var.postgres_password
}

resource "google_sql_database" "database" {
  name     = var.postgres_db
  instance = google_sql_database_instance.main.name
}

resource "google_compute_global_address" "private-ip-db" {
  name          = "private-ip-db"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-ip-db.name]
}
