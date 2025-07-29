resource "google_storage_bucket_object" "function_source" {
  name   = "${var.function_name}-source.zip"
  bucket = var.bucket_name
  source = "${path.module}/${var.source_dir}"
}

resource "google_cloudfunctions_function" "this" {
  name                  = var.function_name
  runtime               = var.runtime
  available_memory_mb   = 256
  source_archive_bucket = var.bucket_name
  source_archive_object = google_storage_bucket_object.function_source.name
  entry_point           = var.entry_point
  trigger_bucket        = var.bucket_name
  region                = var.region
  service_account_email = var.service_account_email

  environment_variables = var.env_vars

  labels = {
    terraform = "true"
  }
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.this.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers" # Or limit to internal service account later
}
