output "connection_name" {
  value = google_sql_database_instance.postgres.connection_name
}

output "instance_name" {
  value = google_sql_database_instance.postgres.name
}

output "public_ip" {
  value = google_sql_database_instance.postgres.public_ip_address
}

output "database_name" {
  value = google_sql_database.PROJECT-NAME.name
}

output "database_user" {
  value = google_sql_user.PROJECT-NAME.name
}

output "password_secret_id" {
  value = google_secret_manager_secret.db_password.secret_id
}
