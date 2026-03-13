output "products_to_embed_topic" {
  value = google_pubsub_topic.products_to_embed.name
}

output "embeddings_completed_topic" {
  value = google_pubsub_topic.embeddings_completed.name
}

output "dead_letter_topic" {
  value = google_pubsub_topic.dead_letter.name
}
