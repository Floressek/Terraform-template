resource "google_sql_database_instance" "postgres" {
  name                = "spokey-db-${var.environment}"
  database_version    = "POSTGRES_16"
  region              = var.region
  project             = var.project_id
  deletion_protection = var.deletion_protection

  settings {
    tier      = var.tier
    disk_size = var.disk_size
    disk_type = "PD_SSD"


    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "allow-all" # Adjust this to restrict access to specific IP ranges
        value = "0.0.0.0/0"
      }
    }

    backup_configuration { # doc-based to be disabled if not necessary on prod
      enabled    = var.environment == "prod" ? true : false
      start_time = "03:00"
    }

    user_labels = {
      environment = var.environment
      project     = var.project_id
    }
  }
}

resource "google_sql_database" "spokey" {
  name     = "spokey"
  instance = google_sql_database_instance.postgres.name
  project  = var.project_id
}

resource "google_sql_user" "spokey" {
  name     = "spokey"
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_password.result
  project  = var.project_id
}

resource "random_password" "db_password" {
  length  = 24
  special = false
}

resource "google_secret_manager_secret" "db_password" {
  secret_id = "spokey-db-password-${var.environment}"
  project   = var.project_id

  replication {
    auto {}
  }

  labels = {
    environment = var.environment
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = random_password.db_password.result
}
