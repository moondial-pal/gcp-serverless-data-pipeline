# main.py (function)
import os
import logging
import uuid
import requests
import functions_framework
from google.auth.transport.requests import Request
from google.oauth2.id_token import fetch_id_token

SESSION = requests.Session()

@functions_framework.cloud_event
def handle_gcs_event(cloud_event):
    data = cloud_event.data
    bucket = data.get("bucket")
    name = data.get("name")

    base_url = os.getenv("CLOUD_RUN_URL", "").rstrip("/")
    path     = os.getenv("CLOUD_RUN_PATH", "/process")  # change to "/process_csv" if that's your API
    if not base_url:
        logging.error("Missing CLOUD_RUN_URL environment variable")
        return

    audience = base_url  # IMPORTANT: audience is base URL only
    try:
        token = fetch_id_token(Request(), audience)
    except Exception as e:
        logging.error(f"Failed to fetch ID token for audience={audience}: {e}")
        raise

    payload = {
        "bucket": bucket,
        # standardize on 'object'; keep 'filename' for backwards compat
        "object": name,
        "filename": name,
        "pipeline_id": str(uuid.uuid4())
    }
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }
    url = f"{base_url}{path}"

    logging.info(f"Calling Cloud Run: {url} payload={payload}")
    try:
        resp = SESSION.post(url, json=payload, headers=headers, timeout=60)
        resp.raise_for_status()
        logging.info(f"Cloud Run responded: {resp.status_code}")
    except requests.HTTPError as e:
        logging.error(f"Cloud Run HTTP error {e.response.status_code}: {e.response.text[:500]}")
        raise
    except Exception as e:
        logging.error(f"Error calling Cloud Run: {e}")
        raise
