output "function_name" {
  description = "The name of the deployed Cloud Function"
  value       = google_cloudfunctions2_function.this.name
}

output "function_region" {
  description = "The region where the Cloud Function is deployed"
  value       = google_cloudfunctions2_function.this.location
}

output "function_service_account" {
  description = "The service account used by the Cloud Function"
  value       = google_cloudfunctions2_function.this.service_config[0].service_account_email
}

output "function_url" {
  description = "The HTTPS URL of the underlying Cloud Run service for the function"
  value       = google_cloudfunctions2_function.this.service_config[0].uri
}
