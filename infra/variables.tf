# 🔥 Required GCP project ID
variable "project_id" {
  description = "GCP Project ID where resources will be created"
  type        = string
}

# 🌎 Default region for GCP resources
variable "region" {
  description = "Default GCP region for resources"
  type        = string
}

# 🗄️ GCS bucket for storing Terraform state
variable "tf_state_bucket" {
  description = "Name of the GCS bucket to store Terraform state"
  type        = string
}

# 📂 Prefix path within the GCS bucket
variable "tf_state_prefix" {
  description = "Path prefix inside GCS bucket for Terraform state"
  type        = string
}
