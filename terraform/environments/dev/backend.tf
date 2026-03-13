terraform {
  backend "gcs" {
    bucket = "spokey-terraform-state"
    prefix = "environments/dev"
  }
}
