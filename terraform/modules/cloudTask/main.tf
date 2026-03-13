resource "google_cloud_tasks_queue" "file_process" {
  name     = "spokey-file-process-${var.environment}-v3"
  location = var.region
  project  = var.project_id
}

resource "google_cloud_tasks_queue" "photo_classification" {
  name     = "spokey-photo-classification-process-${var.environment}-v3"
  location = var.region
  project  = var.project_id
}

resource "google_cloud_tasks_queue" "embeddings" {
  name     = "spokey-embeddings-${var.environment}-v4"
  location = var.region
  project  = var.project_id
}
