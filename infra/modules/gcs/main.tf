resource "google_storage_bucket" "this" {
  name     = "gcs-data-pipeline-${var.environment}"
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
  force_destroy               = true

  labels = {
    environment = var.environment
    terraform   = "true"
  }
}
