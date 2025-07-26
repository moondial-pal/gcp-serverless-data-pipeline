variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "service_name" {
  type        = string
  description = "Name of the Cloud Run service"
}

variable "image_url" {
  type        = string
  description = "URL of the container image to deploy"
}

variable "service_account_email" {
  type        = string
  description = "Service account for Cloud Run to use"
}
