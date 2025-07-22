from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import pipeline

app = FastAPI(title="GCP Serverless Data Pipeline", version="0.1.0")


# Request payload schema
class ProcessRequest(BaseModel):
    bucket: str
    filename: str


@app.get("/")
async def root():
    """Health check endpoint"""
    return {"message": "GCP Serverless Data Pipeline is alive!"}


@app.post("/process")
async def process_csv(request: ProcessRequest):
    """
    Trigger the ETL process for a given CSV file in GCS.
    """
    try:
        result = await pipeline.process_csv(request.bucket, request.filename)
        return {"status": "success", "details": result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
