# 🌱 Development Environment Configuration

# Unique identifier for this deployment
environment = "dev"

# 🔐 GCP project
project_id = "gcp-serverless-data-pipeline"

# 🌍 Region (us-west1 = Oregon)
region = "us-west1"

# ☁️ Terraform remote state config
tf_state_bucket = "data-pipeline-tfstate-dev"
tf_state_prefix = "dev/gcp-serverless-data-pipeline"

# 📦 Artifact Registry repository
repo_name = "gcp-data-pipeline"

# 🪣 GCS bucket for CSV upload and processing
bucket_name = "gcs-data-pipeline-dev"

# Cloud Functions
cloud_function_name = "trigger-fastapi"
cloud_function_entry_point = "trigger_pipeline"
cloud_function_bucket = "gcs-data-pipeline-dev"     # Your bucket
cloud_function_region = "us-west1"
source_dir = "functions_src"


