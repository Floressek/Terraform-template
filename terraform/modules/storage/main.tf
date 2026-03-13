resource "google_storage_bucket" "product_images" {
  name          = "${var.project_id}-PROJECT-NAME-product-${var.environment}"
  location      = var.region
  project       = var.project_id
  force_destroy = var.environment != "prod"

  uniform_bucket_level_access = true

  labels = {
    environment = var.environment
    project     = "PROJECT-NAME"
  }
}
