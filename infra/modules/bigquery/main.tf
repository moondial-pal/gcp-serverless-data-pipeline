resource "google_bigquery_dataset" "this" {
  dataset_id = "${var.environment}_data_pipeline"
  project    = var.project_id
  location   = var.region
  labels = {
    environment = var.environment
    terraform   = "true"
  }
}
