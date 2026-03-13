resource "google_cloud_run_v2_service" "api" {
  name     = "PROJECT-NAME-api-${var.environment}"
  location = var.region
  project  = var.project_id

  template {
    service_account = var.service_account_email

    scaling {
      min_instance_count = 0
      max_instance_count = var.environment == "prod" ? 5 : 1
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.db_connection_name]
      }
    }

    containers {
      image = var.docker_image

      ports {
        container_port = 3000
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      startup_probe {
        initial_delay_seconds = 0
        timeout_seconds       = 1
        period_seconds        = 3
        failure_threshold     = 10
        tcp_socket {
          port = 3000
        }
      }

      env {
        name  = "POSTGRES_HOST"
        value = "/cloudsql/${var.db_connection_name}"
      }

      env {
        name  = "POSTGRES_DB"
        value = var.db_name
      }

      env {
        name  = "POSTGRES_USER"
        value = var.db_user
      }

      env {
        name = "POSTGRES_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = var.db_password_secret_id
            version = "latest"
          }
        }
      }

      env {
        name  = "POSTGRES_PORT"
        value = "5432"
      }

      env {
        name  = "APP_PORT"
        value = "3000"
      }

      env {
        name  = "APP_HOST"
        value = "0.0.0.0"
      }

      env {
        name  = "GCS_BUCKET_NAME"
        value = var.bucket_name
      }

      env {
        name  = "PUBSUB_EMBED_TOPIC"
        value = var.embed_topic
      }

      env {
        name  = "GCP_PROJECT_ID"
        value = var.project_id
      }

      env {
        name  = "NODE_ENV"
        value = var.environment == "prod" ? "production" : "development"
      }

      env {
        name  = "GOTENBERG_URL"
        value = var.gotenberg_url
      }

      env {
        name = "GOOGLE_CLIENT_ID"
        value_source {
          secret_key_ref {
            secret  = var.google_client_id_secret_id
            version = "latest"
          }
        }
      }

      env {
        name = "GOOGLE_CLIENT_SECRET"
        value_source {
          secret_key_ref {
            secret  = var.google_client_secret_secret_id
            version = "latest"
          }
        }
      }

      env {
        name  = "GOOGLE_CALLBACK_URL"
        value = var.google_callback_url
      }

      env {
        name = "SESSION_SECRET"
        value_source {
          secret_key_ref {
            secret  = var.session_secret_secret_id
            version = "latest"
          }
        }
      }

      env {
        name  = "FRONTEND_URL"
        value = var.frontend_url
      }

      env {
        name  = "SESSION_COOKIE_NAME"
        value = var.session_cookie_name
      }

      env {
        name  = "MAXAGE_SESSION_COOKIE"
        value = tostring(var.maxage_session_cookie)
      }

      env {
        name  = "SESSION_TTL_SECONDS"
        value = tostring(var.session_ttl_seconds)
      }

      # Cloud Tasks configuration
      env {
        name  = "GCP_LOCATION"
        value = var.gcp_location
      }

      env {
        name  = "EMBEDDINGS_QUEUE"
        value = var.embeddings_queue
      }

      env {
        name  = "FILE_PROCESS_QUEUE"
        value = var.file_process_queue
      }

      env {
        name  = "PHOTO_CLASSIFICATION_QUEUE"
        value = var.photo_classification_queue
      }

      env {
        name  = "CLOUD_RUN_URL"
        value = var.cloud_run_url
      }

      env {
        name  = "TASKS_SERVICE_ACCOUNT_EMAIL"
        value = var.tasks_service_account_email
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
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
  name     = google_cloud_run_v2_service.api.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
