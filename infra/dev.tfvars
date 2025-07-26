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
