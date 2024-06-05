# VPC
resource "google_compute_network" "vpc" {
  name                    = "infra3-gke"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "infra3-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.0.0.0/24"
}

# Firewall rule: Allow access via HTTP and HTTPS from the internet
# resource "google_compute_firewall" "firewall-web" {
#   name    = "firewall-web"
#   network = google_compute_network.votingly-network.self_link

#   # IP range of the internet
#   source_ranges = ["0.0.0.0/0"]

#   direction   = "INGRESS"
#   source_tags = ["web"]

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "443"]
#   }
# }
