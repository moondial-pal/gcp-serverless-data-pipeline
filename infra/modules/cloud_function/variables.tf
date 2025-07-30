variable "project_id" {
  description = "The GCP project ID where the function will be deployed"
  type        = string
}

variable "region" {
  description = "The region to deploy the Cloud Function"
  type        = string
  default     = "us-west1"
}

variable "bucket_name" {
  description = "The GCS bucket name containing the source code zip"
  type        = string
}

variable "function_name" {
  description = "The name of the Cloud Function"
  type        = string
}

variable "runtime" {
  description = "The runtime to use (e.g. python312)"
  type        = string
  default     = "python312"
}

variable "entry_point" {
  description = "The entry point function in your source code (e.g. 'main')"
  type        = string
}

variable "service_account_email" {
  description = "The service account email used by the function"
  type        = string
}

variable "env_vars" {
  description = "Environment variables for the Cloud Function"
  type        = map(string)
  default     = {}
}

variable "source_dir" {
  description = "Path to the local function source code"
  type        = string
}
