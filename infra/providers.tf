terraform {
  required_version = ">= 1.12.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.44.0"
    }
  }

  backend "gcs" {
    bucket  = var.tf_state_bucket
    prefix  = var.tf_state_prefix
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
