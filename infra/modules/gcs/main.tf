# infra/modules/gcs/main.tf
resource "google_storage_bucket" "this" {
  name     = var.bucket_name
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
  force_destroy               = true  # optional: allows `terraform destroy` to clean up non-empty buckets

  labels = {
    environment = var.environment
    terraform   = "true"
  }
}
