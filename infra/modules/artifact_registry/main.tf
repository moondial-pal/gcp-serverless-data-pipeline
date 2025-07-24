resource "google_artifact_registry_repository" "this" {
  provider   = google
  project    = var.project_id
  location   = var.region
  repository_id = var.repo_name
  description   = "Artifact Registry for GCP Data Pipeline container images"
  format        = "DOCKER"
}
