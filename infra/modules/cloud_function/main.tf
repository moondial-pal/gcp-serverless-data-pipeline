# === Package Function Code ===
# Archive the source code in ./src (don't commit the zip to git)
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"     # keep your code in modules/cloud_function/src/
  output_path = "${path.module}/function.zip"
}

# Upload to GCS with a unique name that changes if code changes
resource "google_storage_bucket_object" "function_source" {
  name   = "${var.function_name}/${data.archive_file.function_zip.output_md5}.zip"
  bucket = var.bucket_name
  source = data.archive_file.function_zip.output_path
}

# === 2nd Gen Cloud Function ===
resource "google_cloudfunctions2_function" "this" {
  name        = var.function_name
  location    = var.region
  description = "Triggered when CSV files are uploaded to GCS"

  build_config {
    runtime     = var.runtime       # e.g. "python312"
    entry_point = var.entry_point   # e.g. "main"
    source {
      storage_source {
        bucket = var.bucket_name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    available_memory      = "256Mi"
    timeout_seconds       = 60
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

# === Cloud Run IAM Binding ===
resource "google_cloud_run_service_iam_member" "invoker" {
  location = var.region
  service  = google_cloudfunctions2_function.this.name
  role     = "roles/run.invoker"
  member   = "allUsers" # TODO: restrict later
}
