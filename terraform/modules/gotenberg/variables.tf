variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-central2"
}

variable "environment" {
  type = string
}

variable "allow_public_access" {
  type    = bool
  default = false
}
