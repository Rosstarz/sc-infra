resource "google_sql_database_instance" "main" {
  name             = "db1"
  region           = "europe_west1"
  database_version = "POSTGRES_15"

  settings {
    tier      = "db-f1-micro"
    disk_type = "PD_HDD"
    disk_size = 10

    # ip_configuration {
    #     private_network = TBA
    # }
  }

  deletion_protection = "true"
}

resource "google_sql_user" "users" {
  name     = "ross"
  instance = google_sql_database_instance.main.name
  password = "changeme"
}

resource "google_sql_database" "database" {
  name     = "prog5db"
  instance = google_sql_database_instance.main.name
}
