output "bucket_name" {
  value = google_storage_bucket.product_images.name
}

output "bucket_url" {
  value = google_storage_bucket.product_images.url
}
