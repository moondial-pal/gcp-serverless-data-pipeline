output "dataset_id" {
  description = "The BigQuery dataset ID"
  value       = google_bigquery_dataset.this.dataset_id
}

output "dataset_full_id" {
  description = "The full BigQuery dataset resource ID"
  value       = google_bigquery_dataset.this.id
}
