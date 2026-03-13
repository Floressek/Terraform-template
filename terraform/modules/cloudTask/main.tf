resource "google_cloud_tasks_queue" "file_process" {
  name     = "PROJECT-NAME-file-process-${var.environment}-v3"
  location = var.region
  project  = var.project_id
}

resource "google_cloud_tasks_queue" "photo_classification" {
  name     = "PROJECT-NAME-photo-classification-process-${var.environment}-v3"
  location = var.region
  project  = var.project_id
}

resource "google_cloud_tasks_queue" "embeddings" {
  name     = "PROJECT-NAME-embeddings-${var.environment}-v4"
  location = var.region
  project  = var.project_id
}
