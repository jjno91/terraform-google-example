module "this" {
  source = "../"
}

terraform {
  backend "gcs" {
    bucket = "jjno91-terraform-state"
  }
}
