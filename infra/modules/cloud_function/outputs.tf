output "function_name" {
  value = google_cloudfunctions_function.this.name
}

output "function_url" {
  value = google_cloudfunctions_function.this.https_trigger_url
}
