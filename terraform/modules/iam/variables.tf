variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "cloud_run_service_names" {
  type        = list(string)
  description = "List of Cloud Run service names that Cloud Tasks can invoke"
}
