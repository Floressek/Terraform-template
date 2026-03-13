terraform {
  backend "gcs" {
    bucket = "PROJECT-NAME-terraform-state"
    prefix = "environments/dev"
  }
}
