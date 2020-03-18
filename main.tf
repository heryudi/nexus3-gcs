provider "google" {
  # credentials = file("account.json")
  project     = "aliz-hw-heryudi"
  region      = "asia-southeast1"
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "asia-southeast1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "gke-node-pool"
  location   = "asia-southeast1"
  cluster    = "gke-cluster"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_storage_bucket" "nexus-repository" {
  name          = "nexus-repository-bucket"
  location      = "ASIA"
  force_destroy = true

}
