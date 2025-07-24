variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "The GCP region for resources"
}

variable "repo_name" {
  type        = string
  description = "The name of the Artifact Registry repository"
}
