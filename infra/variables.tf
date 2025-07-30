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

variable "cloud_function_entry_point" {
  type        = string
  description = "The entry point function for the Cloud Function"
}

variable "cloud_function_bucket" {
  type        = string
  description = "The bucket that stores the function source archive"
}

variable "source_dir" {
  type        = string
  description = "Path to the Cloud Function source directory"
}

variable "cloud_function_name" {
  type        = string
  description = "Name of the Cloud Function"
}

variable "cloud_function_region" {
  type        = string
  description = "Region for the Cloud Function deployment"
}

