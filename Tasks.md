# 🚀 GCP Serverless Data Pipeline – Project Checklist

## 📦 Containerization (Done ✅)
- [x] Create Dockerfile for FastAPI app
- [x] Install project dependencies (pip-only in Docker)
- [x] Build Docker image locally: `docker build -t gcp-data-pipeline .`
- [x] Run container locally and test API: `docker run -p 8080:8080 gcp-data-pipeline`
- [x] Verify FastAPI is live at `http://localhost:8080/docs`

---

## ☁️ Terraform – Provision GCP Infrastructure

- [x] Set up Terraform project directory (`infra/`)
    - Create `infra/` in repo root
    - Add base files: `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`
    - Create environment config: `infra/dev.tfvars`
    - Scaffold `infra/staging.tfvars` and `infra/prod.tfvars`

- [x] Configure `providers.tf`
    - Define required Terraform and Google provider versions
    - Parameterize GCS backend with:
        - `tf_state_bucket`
        - `tf_state_prefix`
    - Reference `project_id` and `region` as variables

- [x] Define `variables.tf`
    - Add variables for:
        - `project_id`
        - `region`
        - `repo_name`
        - `tf_state_bucket`
        - `tf_state_prefix`

- [x] Create `dev.tfvars`
    - Add actual values for:
        - `project_id`
        - `region`
        - `repo_name`
        - `tf_state_bucket`
        - `tf_state_prefix`

- [ ] Modularize resources
    - Create `modules/` directory
    - Create modules for:
        - [x] Artifact Registry ✅
        - [x] Cloud Run
        - [x] GCS bucket
        - [x] BigQuery dataset & table
        - [x] Enable GCP APIs ✅

- [x] Define resources in `main.tf`
    - Use modules
    - Reference variables for all values

- [x] Configure GCS backend for Terraform state
    - Initialize with:
        ```bash
        terraform init \
          -backend-config="bucket=data-pipeline-tfstate-dev" \
          -backend-config="prefix=dev/gcp-serverless-data-pipeline"
        ```

- [x] Run Terraform commands
    - Plan:  
        ```bash
        terraform plan -var-file=dev.tfvars
        ```
    - Apply:  
        ```bash
        terraform apply -var-file=dev.tfvars
        ```

---

## 🐍 FastAPI Application Development
- [x] Scaffold FastAPI structure (`main.py`, `pipeline.py`, `utils.py`)
- [ ] Design API endpoints:
    - [ ] `GET /` – health check
    - [ ] `POST /process` – trigger CSV processing
- [ ] Implement `pipeline.py`:
    - [ ] Download CSV from GCS
    - [ ] Process/transform data with Pandas
    - [ ] Load transformed data into BigQuery
- [ ] Implement `utils.py`:
    - [ ] Helper: download from GCS
    - [ ] Helper: upload to BigQuery
    - [ ] Logging utilities
- [ ] Add proper error handling & logging
- [ ] Write unit tests for pipeline logic (optional)

---

## 🚀 Deploy to GCP
- [ ] Push Docker image to Artifact Registry:
    ```bash
    gcloud builds submit --tag us-west1-docker.pkg.dev/PROJECT_ID/gcp-data-pipeline/gcp-data-pipeline
    ```
- [ ] Deploy Cloud Run service:
    ```bash
    gcloud run deploy gcp-data-pipeline \
      --image us-west1-docker.pkg.dev/PROJECT_ID/gcp-data-pipeline/gcp-data-pipeline \
      --platform managed \
      --region us-west1 \
      --allow-unauthenticated
    ```
- [ ] Test API endpoint in Cloud Run:
    - Open Cloud Run URL in browser
    - Verify `/docs` and API health

---

## 🔄 Automation (CI/CD)
- [ ] Set up Cloud Build trigger:
    - Trigger on `main` branch push
    - Build Docker image
    - Push to Artifact Registry
    - Deploy to Cloud Run
- [ ] Test CI/CD flow with a commit

---

## 🔒 Security Best Practices
- [x] Use least privilege IAM roles (Terraform SA with scoped roles)
- [x] Enable Cloud APIs with Terraform
- [ ] Store secrets in Secret Manager (auth key, config)
- [ ] Configure Cloud Run to use custom service account
- [ ] Enable ingress/egress control for Cloud Run

---

## 📑 Documentation
- [ ] Update README.md:
    - Architecture diagram
    - Deployment instructions
    - API usage guide
    - Terraform usage guide
- [ ] Create `RUNBOOK.md` for client ops team

---

## ✅ Final Testing
- [ ] Upload sample CSV to GCS bucket
- [ ] Trigger API and verify:
    - Data processed correctly
    - Data loaded to BigQuery
    - Logs appear in Cloud Logging
- [ ] Clean up unused resources

---

## 🎯 Stretch Goals
- [ ] Add Pub/Sub trigger for auto-processing on GCS upload
- [ ] Support multiple file formats (JSON, Parquet)
- [ ] Add API authentication (e.g., API key or OAuth)
