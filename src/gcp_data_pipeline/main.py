from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

# ✅ absolute import from our package
from gcp_data_pipeline.pipeline import process_csv

app = FastAPI(title="GCP Data Pipeline API")

# --- Health check ---
@app.get("/")
def health_check():
    return {"status": "ok", "message": "Pipeline API is live"}

# --- Request model ---
class ProcessRequest(BaseModel):
    bucket: str
    filename: str

# --- Processing endpoint ---
@app.post("/process")
def process_file(req: ProcessRequest):
    try:
        result = process_csv(req.bucket, req.filename)
        return {"status": "success", "details": result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
