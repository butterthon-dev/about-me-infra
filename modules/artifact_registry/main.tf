resource "google_artifact_registry_repository" "ar_about_me" {
  provider      = google-beta
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"
}
