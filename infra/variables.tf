variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region to deploy to"
  type        = string
}

variable "tf_state_bucket" {
  description = "GCS bucket for Terraform remote state"
  type        = string
}

variable "tf_state_prefix" {
  description = "Path prefix for Terraform remote state"
  type        = string
}

variable "repo_name" {
  description = "Artifact Registry repository name"
  type        = string
}

variable "bucket_name" {
  description = "Name of the GCS bucket for data pipeline CSVs"
  type        = string
}
