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

variable "api_url" {
  type = string
  description = "Backend Cloud Run URL for proxy"
}

variable "allow_public_access" {
  type    = bool
  default = false
}