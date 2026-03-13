resource "google_cloud_run_v2_service" "gotenberg" {
  name     = "spokey-gotenberg-${var.environment}"
  location = var.region
  project  = var.project_id

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = var.environment == "prod" ? 3 : 1
    }

    containers {
      image = "gotenberg/gotenberg:8-cloudrun"

      ports {
        container_port = 3000
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "1Gi"
        }
      }
    }
  }

  labels = {
    environment = var.environment
    project     = "spokey"
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  count    = var.allow_public_access ? 1 : 0
  name     = google_cloud_run_v2_service.gotenberg.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
