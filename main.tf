resource "google_container_cluster" "this" {
  name                     = var.name
  location                 = "us-central1-a"
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

resource "google_container_node_pool" "this" {
  name       = var.name
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
