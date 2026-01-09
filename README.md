# GCP Serverless Data Pipeline

This project implements a serverless data pipeline on Google Cloud Platform (GCP) using Terraform-based Infrastructure as Code. The system ingests CSV datasets uploaded to Cloud Storage, triggers event-driven processing, applies lightweight transformations, and loads structured results into BigQuery for downstream analytics.

Designed as a portfolio project, it emphasizes practical cloud architecture concerns including cost efficiency, least-privilege IAM, scalability, and operational simplicity.

---

## 📦 Features

- ☁️ **Serverless architecture**
  - Cloud Storage triggers serverless compute to process CSV uploads
  - Transformed data is stored in BigQuery for analysis
- 🔒 **Security by design**
  - Least privilege IAM roles
  - Service account isolation
  - Secure GCS buckets
- 🏗️ **Infrastructure as Code**
  - Modular Terraform configuration
  - Remote backend with GCS for state management

## 📦 Planned Enhancements
These enhancements are intentionally deferred to keep the initial design focused on core data flow and infrastructure boundaries.

- 🚀 **Deployment automation**
  - Add Cloud Build triggers for automated infrastructure and service deployments
- 📊 **Observability**
  - Integrate Cloud Logging and Cloud Monitoring dashboards
  - Add uptime checks for critical endpoints

---

## 🛠️ Technologies

- **Google Cloud Platform (GCP)**
  - Cloud Storage
  - Cloud Run Functions (Python)
  - BigQuery
  - IAM
- **Terraform** (modular setup with GCS remote backend)
- **Python** for serverless data transformation

---

## 📐 Architecture

[Client Uploads CSV] → [Cloud Storage Bucket] → [Cloud Function (ETL)]
↓
[Processed Data in BigQuery] → [Downstream Analytics / BI Tools]


 Cloud Storage bucket acts as an ingestion point for CSV uploads.
- Cloud Run Function is triggered on object creation:
  - Validates and transforms data.
  - Loads processed data into BigQuery.
- The pipeline is designed to be stateless and event-driven, with IAM-scoped service accounts and no long-lived credentials.

---

## 🚀 Getting Started

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.5+
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- Python 3.10+
- GCP project with billing enabled

### Clone Repository
```bash
git clone https://github.com/moondial-pal/gcp-serverless-data-pipeline.git
cd gcp-serverless-data-pipeline
```
Initialize Terraform
```Bash
terraform init
```
Deploy Infrastructure
```Bash
terraform apply
```
Deploy Cloud Function
```Bash
gcloud functions deploy process_csv \
  --runtime python310 \
  --trigger-bucket <your-ingestion-bucket> \
  --entry-point main \
  --source cloud_run_function/
```

## 📄 Documentation

  [Architecture Overview](https://www.gcp-serverless-data-pipeline-architecture/luispal.com)

  [Terraform Modules](https://www.gcp-serverless-data-pipeline-tfmods/luispal.com)

  [Runbook](https://www.gcp-serverless-data-pipeline-runbook/luispal.com)
