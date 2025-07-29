variable "function_name" {
  description = "Name of the Cloud Function"
  type        = string
}

variable "entry_point" {
  description = "Name of the entry point function in source code"
  type        = string
}

variable "bucket_name" {
  description = "GCS bucket name for both source and trigger"
  type        = string
}

variable "source_dir" {
  description = "Path to the zipped function source code"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "runtime" {
  description = "Cloud Function runtime"
  type        = string
  default     = "python310"
}

variable "env_vars" {
  description = "Map of environment variables"
  type        = map(string)
  default     = {}
}

variable "service_account_email" {
  description = "IAM service account email for the function"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}
