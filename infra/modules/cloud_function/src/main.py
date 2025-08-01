import functions_framework
import requests
import os

CLOUD_RUN_URL = os.environ.get("CLOUD_RUN_URL")

@functions_framework.cloud_event
def handle_gcs_event(cloud_event):
    bucket = cloud_event.data["bucket"]
    name = cloud_event.data["name"]

    print(f"Received file: {name} in bucket: {bucket}")

    # Call Cloud Run FastAPI endpoint
    if CLOUD_RUN_URL:
        resp = requests.post(
            f"{CLOUD_RUN_URL}/process_csv",
            json={"bucket": bucket, "file": name},
            timeout=30,
        )
        print(f"Cloud Run response: {resp.status_code} - {resp.text}")

    return "ok"
