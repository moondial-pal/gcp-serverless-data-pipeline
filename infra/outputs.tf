# Cloud Run
output "cloud_run_url" {
  description = "Deployed Cloud Run service URL"
  value       = module.cloud_run.cloud_run_url
}

# BigQuery
output "bq_dataset_id" {
  description = "The BigQuery dataset ID"
  value       = module.bigquery.dataset_id
}

output "bq_dataset_full_id" {
  description = "The full BigQuery dataset resource ID"
  value       = module.bigquery.dataset_full_id
}
