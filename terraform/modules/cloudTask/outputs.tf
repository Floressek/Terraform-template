output "file_process_queue_name" {
  value = google_cloud_tasks_queue.file_process.name
}

output "file_process_queue_id" {
  value = google_cloud_tasks_queue.file_process.id
}

output "photo_classification_process_queue_name" {
  value = google_cloud_tasks_queue.photo_classification.name
}

output "photo_classification_process_queue_id" {
  value = google_cloud_tasks_queue.photo_classification.id
}

output "embeddings_queue_name" {
  value = google_cloud_tasks_queue.embeddings.name
}

output "embeddings_queue_id" {
  value = google_cloud_tasks_queue.embeddings.id
}
