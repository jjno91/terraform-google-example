resource "google_project" "this" {
  name       = var.name
  project_id = "${var.name}-${random_string.this.result}"
}

resource "random_string" "this" {
  length  = 6
  special = false
  upper   = false
}

resource "google_container_cluster" "this" {
  name                     = "this"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  project                  = google_project.this.id

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "this" {
  name       = "this"
  location   = "us-central1-a"
  cluster    = google_container_cluster.this.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "f1-micro"

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
