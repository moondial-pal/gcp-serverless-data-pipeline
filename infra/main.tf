
module "enable_apis" {
  source     = "./modules/apis"
  project_id = var.project_id
  apis       = [
    "cloudresourcemanager.googleapis.com", # Ensure this is listed
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "bigquery.googleapis.com",
    "storage.googleapis.com",
    "cloudfunctions.googleapis.com"
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
  source                = "./modules/cloud_run"
  project_id            = var.project_id
  region                = var.region
  service_name          = "gcp-data-api"
  image_url             = "gcr.io/cloudrun/hello"
  service_account_email = "terraform@gcp-serverless-data-pipeline.iam.gserviceaccount.com"

  depends_on = [module.enable_apis]
}

# BQ
module "bigquery" {
  source                = "./modules/bigquery"
  project_id            = var.project_id
  environment           = var.environment
  region                = var.region
  service_account_email = "terraform@${var.project_id}.iam.gserviceaccount.com"

  depends_on = [module.enable_apis]
}

# Cloud Functions
module "cloud_function" {
  source                = "../modules/cloud_function"
  function_name         = "gcs-trigger-csv-handler"
  entry_point           = "handle_gcs_event"
  bucket_name           = module.gcs_bucket.bucket_name
  source_dir            = "function_src"
  region                = "us-west1"
  project_id            = var.project_id
  runtime               = "python310"
  service_account_email = "terraform@${var.project_id}.iam.gserviceaccount.com"
  env_vars              = {
    CLOUD_RUN_URL = module.cloud_run.cloud_run_url
  }

  depends_on = [module.enable_apis]
}
