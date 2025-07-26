# infra/modules/gcs/variables.tf
variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, staging, prod)"
}

variable "bucket_name" {
  type        = string
  description = "Name of the GCS bucket"
}
