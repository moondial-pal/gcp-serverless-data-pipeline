resource "google_project_service" "artifact_registry" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

# Add more APIs here as needed, like:
# - Cloud Run
# - BigQuery
# - Cloud Storage
# - IAM
