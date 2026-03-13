locals {
  api_url      = "https://spokey-api-${var.environment}-${data.google_project.project.number}.${var.region}.run.app"
  frontend_url = "https://spokey-client-${var.environment}-${data.google_project.project.number}.${var.region}.run.app"
}

data "google_project" "project" {
  project_id = var.project_id
}

module "iam" {
  source = "../../modules/iam"

  project_id              = var.project_id
  environment             = var.environment
  region                  = var.region
  cloud_run_service_names = ["spokey-api-${var.environment}"]
}

module "auth" {
  source = "../../modules/auth"

  project_id           = var.project_id
  environment          = var.environment
  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret
}

module "database" {
  source = "../../modules/database"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  tier                = "db-f1-micro"
  disk_size           = 10
  deletion_protection = false
}

module "storage" {
  source = "../../modules/storage"

  project_id  = var.project_id
  region      = var.region
  environment = var.environment
}

module "pubsub" {
  source = "../../modules/pubsub"

  project_id  = var.project_id
  environment = var.environment
}

module "cloud_task" {
  source = "../../modules/cloudTask"

  project_id  = var.project_id
  region      = var.region
  environment = var.environment
}

module "gotenberg" {
  source = "../../modules/gotenberg"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  allow_public_access = false
}

module "api" {
  source = "../../modules/api"

  project_id                     = var.project_id
  region                         = var.region
  environment                    = var.environment
  docker_image                   = var.docker_image
  service_account_email          = module.iam.api_service_account_email
  db_connection_name             = module.database.connection_name
  db_name                        = module.database.database_name
  db_user                        = module.database.database_user
  db_password_secret_id          = module.database.password_secret_id
  bucket_name                    = module.storage.bucket_name
  embed_topic                    = module.pubsub.products_to_embed_topic
  gotenberg_url                  = module.gotenberg.url
  google_client_id_secret_id     = module.auth.google_client_id_secret_id
  google_client_secret_secret_id = module.auth.google_client_secret_secret_id
  google_callback_url            = "${local.api_url}/api/auth/login/callback"
  session_secret_secret_id       = module.auth.session_secret_secret_id
  frontend_url                   = local.frontend_url
  allow_public_access            = true

  # Cloud Tasks configuration
  gcp_location                   = var.region
  embeddings_queue               = module.cloud_task.embeddings_queue_name
  file_process_queue             = module.cloud_task.file_process_queue_name
  photo_classification_queue     = module.cloud_task.photo_classification_process_queue_name
  cloud_run_url                  = local.api_url
  tasks_service_account_email    = module.iam.api_service_account_email
}

module "frontend" {
  source = "../../modules/frontend"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  docker_image        = var.frontend_docker_image
  api_url             = local.api_url
  allow_public_access = true
}
