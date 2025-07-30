# GCP Serverless Data Pipeline

This project demonstrates a serverless data pipeline on Google Cloud Platform (GCP) using **Terraform** for Infrastructure as Code (IaC). It processes CSV datasets uploaded by teams, applies basic transformations, and loads the results into **BigQuery** for analytics dashboards.  

Designed as a hands-on lab and portfolio project, it showcases GCP architecture best practices for cost efficiency, security, and scalability.

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
- 🚀 **CI/CD**
  - Cloud Build pipeline for automatic deployments
- 📊 **Logging & Monitoring**
  - Stackdriver logging enabled
  - Uptime checks configured

---

## 🛠️ Technologies

- **Google Cloud Platform (GCP)**
  - Cloud Storage
  - Cloud Functions (Python)
  - BigQuery
  - IAM
  - Cloud Build
  - Stackdriver (Logging & Monitoring)
- **Terraform** (modular setup with GCS remote backend)
- **Python** for serverless data transformation

---

## 📐 Architecture

[Client Uploads CSV] → [Cloud Storage Bucket] → [Cloud Function (ETL)]
↓
[Processed Data in BigQuery] → [Analytics Dashboards]


- Cloud Storage bucket acts as an ingestion point for CSVs.
- Cloud Function is triggered on upload:
  - Validates and transforms data.
  - Loads processed data into BigQuery.
- Stackdriver logs events and errors for observability.

---

## 🚀 Getting Started

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.5+
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- Python 3.10+
- GCP project with billing enabled

### Clone Repository
```bash
git clone https://github.com/<your-username>/gcp-serverless-data-pipeline.git
cd gcp-serverless-data-pipeline
```
```bash
Initialize Terraform
```
```Bash
terraform init
```
```Bash
Deploy Infrastructure
```
```Bash
terraform apply
```
```Bash
Deploy Cloud Function
```
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
