# GKE cluster
# data "google_container_engine_versions" "gke_version" {
#   location       = "us-central1"
#   version_prefix = "1.28.9"
# }

resource "google_container_cluster" "primary" {
  name                = "${var.project_name}-gke"
  location            = var.zone
  deletion_protection = false

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
# allows node pools to be added and removed without recreating the cluster. 
resource "google_container_node_pool" "primary_nodes" {
  name     = "${var.project_name}-gke-nodes"
  location = var.zone
  cluster  = google_container_cluster.primary.name

  # version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = "g1-small"
    disk_size_gb = 24
    disk_type    = "pd-standard"

    tags = ["gke-node", "${var.project_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
