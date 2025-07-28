resource "google_bigquery_dataset" "this" {
  dataset_id = "${var.environment}_data_pipeline"
  project    = var.project_id
  location   = var.region

  labels = {
    environment = var.environment
    terraform   = "true"
  }
}

resource "google_project_iam_member" "bigquery_admin" {
  project = var.project_id
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:${var.service_account_email}"
}
