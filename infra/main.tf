
module "enable_apis" {
  source     = "./modules/apis"
  project_id = var.project_id
  apis = [
    "cloudresourcemanager.googleapis.com", # Ensure this is listed
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "bigquery.googleapis.com",
    "storage.googleapis.com"
  ]
}

# Atifact Registry
module "artifact_registry" {
  source     = "./modules/artifact_registry"
  project_id = var.project_id
  region     = var.region
  repo_name  = var.repo_name

  depends_on = [module.enable_apis]
}

# Google Cloud Storage
module "gcs_bucket" {
  source      = "./modules/gcs"
  project_id  = var.project_id
  region      = var.region
  bucket_name = "gcs-data-pipeline-${var.environment}"
  environment = "dev"

  depends_on = [module.enable_apis]
}
