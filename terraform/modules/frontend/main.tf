resource "google_cloud_run_v2_service" "frontend" {
  name     = "PROJECT-NAME-client-${var.environment}"
  location = var.region
  project  = var.project_id

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = var.environment == "prod" ? 3 : 1
    }

    containers {
      image = var.docker_image
      ports {
        container_port = 80
      }

      resources {
        limits = {
          cpu    = 1
          memory = "512Mi"
        }
      }

      env {
        name  = "API_URL"
        value = var.api_url
      }
    }
  }

  labels = {
    environment = var.environment
    project     = "PROJECT-NAME"
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  count    = var.allow_public_access ? 1 : 0
  name     = google_cloud_run_v2_service.frontend.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
