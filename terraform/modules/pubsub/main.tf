# topic names:
# 1. embeddings.process – for processing raw data into embeddings
# 2. embeddings.ready – for matching/comparing ready embeddings
# 3. dead.letter.queue – messages land here after 5 failed attempts (prevents infinite loops)

resource "google_pubsub_topic" "products_to_embed" {
  name    = "spokey-products-to-embed-${var.environment}"
  project = var.project_id

  labels = {
    environment = var.environment
    project     = "spokey"
  }
}

resource "google_pubsub_topic" "embeddings_completed" {
  name    = "spokey-embeddings-completed-${var.environment}"
  project = var.project_id

  labels = {
    environment = var.environment
    project     = "spokey"
  }
}

resource "google_pubsub_topic" "dead_letter" {
  name    = "spokey-dead-letter-${var.environment}"
  project = var.project_id

  labels = {
    environment = var.environment
    project     = "spokey"
  }
}

resource "google_pubsub_subscription" "embed_worker" {
  name    = "spokey-embed-worker-${var.environment}"
  topic   = google_pubsub_topic.products_to_embed.id
  project = var.project_id

  ack_deadline_seconds = 120

  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "300s"
  }

  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.dead_letter.id
    max_delivery_attempts = 5
  }
}

resource "google_pubsub_subscription" "match_worker" {
  name    = "spokey-match-worker-${var.environment}"
  topic   = google_pubsub_topic.embeddings_completed.id
  project = var.project_id

  ack_deadline_seconds = 120

  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "300s"
  }

  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.dead_letter.id
    max_delivery_attempts = 5
  }
}

resource "google_pubsub_subscription" "dead_letter_sub" {
  name    = "spokey-dead-letter-sub-${var.environment}"
  topic   = google_pubsub_topic.dead_letter.id
  project = var.project_id
}
