from gcp_data_pipeline.utils import download_from_gcs, upload_to_bigquery

def process_csv(bucket: str, filename: str):
    # TODO: implement real ETL
    print(f"Processing file: gs://{bucket}/{filename}")

    # Placeholder logic
    return {
        "bucket": bucket,
        "filename": filename,
        "rows_processed": 0,
        "status": "not implemented yet"
    }
