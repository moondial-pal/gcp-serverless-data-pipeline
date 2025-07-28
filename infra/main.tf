
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
  environment = "dev"
  bucket_name = "gcs-data-pipeline-${var.environment}"

  depends_on = [module.enable_apis]
}

# Cloud Run
module "cloud_run" {
  source               = "./modules/cloud_run"
  project_id           = var.project_id
  region               = var.region
  service_name         = "gcp-data-api"
  image_url            = "gcr.io/cloudrun/hello"
  service_account_email = "terraform@gcp-serverless-data-pipeline.iam.gserviceaccount.com"

  depends_on = [module.enable_apis]
}

module "bigquery" {
  source      = "./modules/bigquery"
  project_id  = var.project_id
  environment = var.environment
  region      = var.region

  depends_on = [module.enable_apis]
}
