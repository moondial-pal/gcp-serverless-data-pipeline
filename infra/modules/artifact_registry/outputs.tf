output "artifact_registry_repo_id" {
  description = "The ID of the Artifact Registry repository"
  value       = google_artifact_registry_repository.this.id
}
