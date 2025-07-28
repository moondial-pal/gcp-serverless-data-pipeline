variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region (also used as BigQuery dataset location)"
  type        = string
}

variable "environment" {
  description = "Environment name (used in dataset_id and labels)"
  type        = string
}
