# Create a zip archive of the function source
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/gcs-trigger-csv-handler.zip"
}

# Upload the source to your GCS bucket
resource "google_storage_bucket_object" "function_source" {
  name   = "${var.function_name}.zip"
  bucket = var.bucket_name
  source = data.archive_file.function_zip.output_path
}

# 2nd Gen Cloud Function
resource "google_cloudfunctions2_function" "this" {
  name        = var.function_name
  location    = var.region
  description = "Triggered when CSV files are uploaded to GCS"

  build_config {
    runtime     = var.runtime             # e.g. "python312"
    entry_point = var.entry_point         # e.g. "main"
    source {
      storage_source {
        bucket = var.bucket_name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    available_memory   = "256Mi"
    timeout_seconds    = 60
    service_account_email = var.service_account_email
    environment_variables = var.env_vars
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.storage.object.v1.finalized"
    event_filters {
      attribute = "bucket"
      value     = var.bucket_name
    }
    retry_policy = "RETRY_POLICY_RETRY"
  }

  labels = {
    terraform = "true"
  }
}

# In 2nd Gen, Cloud Functions run on Cloud Run under the hood.
# IAM is managed via google_cloud_run_service_iam_member.
resource "google_cloud_run_service_iam_member" "invoker" {
  location = var.region
  service  = google_cloudfunctions2_function.this.name
  role     = "roles/run.invoker"
  member   = "allUsers" # tighten later to only allow specific callers
}
