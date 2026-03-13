variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
  default     = "europe-central2"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "docker_image" {
  type        = string
  description = "Docker image for Cloud Run service"
  default     = "gcr.io/cloudrun/hello"
}

variable "frontend_docker_image" {
  type        = string
  description = "Docker image for Cloud Run frontend"
  default     = "gcr.io/cloudrun/hello"
}

variable "google_client_id" {
  type        = string
  description = "Google OAuth Client ID"
  sensitive   = true
}

variable "google_client_secret" {
  type        = string
  description = "Google OAuth Client Secret"
  sensitive   = true
}

variable "api_url" {
  type        = string
  description = "API URL for frontend configuration"
  default     = "https://spokey-api-dev.run.app"
}

variable "frontend_url" {
  type        = string
  description = "Frontend URL for API CORS configuration"
  default     = "https://spokey-client-dev.run.app"
}
