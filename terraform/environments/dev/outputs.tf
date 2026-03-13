output "cloud_run_url" {
  value = module.api.url
}

output "database_connection_name" {
  value = module.database.connection_name
}

output "database_public_ip" {
  value = module.database.public_ip
}

output "gotenberg_url" {
  value = module.gotenberg.url
}

output "bucket_name" {
  value = module.storage.bucket_name
}

output "embed_topic" {
  value = module.pubsub.products_to_embed_topic
}

output "file_process_queue_name" {
  value = module.cloud_task.file_process_queue_name
}

output "photo_classification_queue_name" {
  value = module.cloud_task.photo_classification_process_queue_name
}

output "embeddings_queue_name" {
  value = module.cloud_task.embeddings_queue_name
}

output "frontend_url" {
  value = module.frontend.url
}

output "api_service_account_email" {
  value       = module.iam.api_service_account_email
  description = "Email of the API service account - use this for TASKS_SERVICE_ACCOUNT_EMAIL"
}
