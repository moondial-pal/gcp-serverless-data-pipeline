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
- [x] Configure `providers.tf`
- [x] Define `variables.tf`
- [x] Create `dev.tfvars`
- [x] Modularize resources
    - [x] Artifact Registry ✅
    - [x] Cloud Run (test container deployed ✅)
    - [x] GCS bucket ✅
    - [x] BigQuery dataset & table ✅
    - [x] Enable GCP APIs ✅
    - [x] Cloud Function + Eventarc trigger ✅
- [x] Define resources in `main.tf`
- [x] Configure GCS backend for Terraform state
- [x] Run Terraform plan/apply successfully ✅

### 🔎 Terraform Outputs Cleanup
- [ ] Review and finalize `outputs.tf` for each module:
  - [ ] Artifact Registry
  - [ ] Cloud Run
  - [ ] GCS
  - [ ] BigQuery
  - [ ] Cloud Function
  - [ ] APIs
- [ ] Ensure consistent naming conventions across outputs
- [ ] Reference outputs in root `outputs.tf` for easier consumption

---

## 🐍 FastAPI Application Development
- [x] Scaffold FastAPI structure (`main.py`, `pipeline.py`, `utils.py`)
- [ ] Design API endpoints:
    - [ ] `GET /` – health check
    - [ ] `POST /process` – trigger CSV processing
- [ ] Implement `pipeline.py`:
    - [ ] Accept filename/path from request
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
- [x] Deploy test Cloud Run service (container boots and `/docs` is accessible ✅)
- [ ] Push production Docker image with real pipeline code to Artifact Registry
- [ ] Update Cloud Run deployment to use production image
- [ ] Test API endpoint in Cloud Run:
    - Open Cloud Run URL in browser
    - Verify `/docs` and API health with real code

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
- [x] Use least privilege IAM roles
- [x] Enable Cloud APIs with Terraform
- [ ] Store secrets in Secret Manager (auth key, config)
- [ ] Configure Cloud Run to use custom service account
- [ ] Enable ingress/egress control for Cloud Run
- [ ] Restrict Cloud Function `invoker` (currently `allUsers`)

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
