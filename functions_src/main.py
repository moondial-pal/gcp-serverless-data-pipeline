import functions_framework
import requests
import os
import logging

@functions_framework.cloud_event
def handle_gcs_event(cloud_event):
    data = cloud_event.data

    bucket = data["bucket"]
    name = data["name"]

    cloud_run_url = os.getenv("CLOUD_RUN_URL")
    if not cloud_run_url:
        logging.error("Missing CLOUD_RUN_URL environment variable")
        return

    payload = {
        "bucket": bucket,
        "filename": name
    }

    try:
        logging.info(f"Triggering Cloud Run: {cloud_run_url}/process with payload: {payload}")
        response = requests.post(f"{cloud_run_url}/process", json=payload)
        response.raise_for_status()
        logging.info(f"Cloud Run responded with: {response.status_code}")
    except Exception as e:
        logging.error(f"Error triggering Cloud Run: {e}")
