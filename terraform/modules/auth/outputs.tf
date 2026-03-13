output "google_client_id_secret_id" {
  value = google_secret_manager_secret.google_client_id.secret_id
}

output "google_client_secret_secret_id" {
  value = google_secret_manager_secret.google_client_secret.secret_id
}

output "session_secret_secret_id" {
  value = google_secret_manager_secret.session_secret.secret_id
}
