variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "docker_image" {
  type    = string
  default = "gcr.io/cloudrun/hello"
}

variable "service_account_email" {
  type = string
}

variable "db_connection_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password_secret_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "gotenberg_url" {
  type    = string
  default = ""
}

variable "embed_topic" {
  type = string
}

variable "allow_public_access" {
  type    = bool
  default = false
}

variable "google_client_id_secret_id" {
  type = string
}

variable "google_client_secret_secret_id" {
  type = string
}

variable "google_callback_url" {
  type = string
}

variable "session_secret_secret_id" {
  type = string
}

variable "frontend_url" {
  type = string
}

variable "session_cookie_name" {
  type    = string
  default = "connect.sid"
}

variable "maxage_session_cookie" {
  type    = number
  default = 86400000
}

variable "session_ttl_seconds" {
  type    = number
  default = 86400
}

# Cloud Tasks configuration
variable "gcp_location" {
  type = string
}

variable "embeddings_queue" {
  type = string
}

variable "file_process_queue" {
  type = string
}

variable "photo_classification_queue" {
  type = string
}

variable "cloud_run_url" {
  type = string
}

variable "tasks_service_account_email" {
  type = string
}
