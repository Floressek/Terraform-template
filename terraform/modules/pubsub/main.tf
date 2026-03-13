# topic names:
# 1. embeddings.process – for processing raw data into embeddings
# 2. embeddings.ready – for matching/comparing ready embeddings
# 3. dead.letter.queue – messages land here after 5 failed attempts (prevents infinite loops)

resource "google_pubsub_topic" "products_to_embed" {
  name    = "PROJECT-NAME-products-to-embed-${var.environment}"
  project = var.project_id

  labels = {
    environment = var.environment
    project     = "PROJECT-NAME"
  }
}

resource "google_pubsub_topic" "embeddings_completed" {
  name    = "PROJECT-NAME-embeddings-completed-${var.environment}"
  project = var.project_id

  labels = {
    environment = var.environment
    project     = "PROJECT-NAME"
  }
}

resource "google_pubsub_topic" "dead_letter" {
  name    = "PROJECT-NAME-dead-letter-${var.environment}"
  project = var.project_id

  labels = {
    environment = var.environment
    project     = "PROJECT-NAME"
  }
}

resource "google_pubsub_subscription" "embed_worker" {
  name    = "PROJECT-NAME-embed-worker-${var.environment}"
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
  name    = "PROJECT-NAME-match-worker-${var.environment}"
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
  name    = "PROJECT-NAME-dead-letter-sub-${var.environment}"
  topic   = google_pubsub_topic.dead_letter.id
  project = var.project_id
}
