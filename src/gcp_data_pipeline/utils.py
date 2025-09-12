"""Utility helpers for interacting with GCP services.

This module provides small wrappers around Google Cloud clients used by the
pipeline.  It centralises logging configuration so that the rest of the
application can simply import and use the helpers without worrying about
setting up loggers.
"""

from __future__ import annotations

import logging
from typing import Any

import pandas as pd
from google.cloud import bigquery, storage


def get_logger(name: str) -> logging.Logger:
    """Return a module level logger configured for console output.

    The first time a logger is requested this will attach a ``StreamHandler``
    with a simple format.  Subsequent calls with the same name will return the
    already configured logger.
    """

    logger = logging.getLogger(name)
    if not logger.handlers:
        handler = logging.StreamHandler()
        formatter = logging.Formatter(
            "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(logging.INFO)
    return logger


logger = get_logger(__name__)


def download_from_gcs(bucket: str, filename: str, local_path: str) -> None:
    """Download ``filename`` from ``bucket`` into ``local_path``.

    Parameters
    ----------
    bucket:
        Name of the Cloud Storage bucket.
    filename:
        Path to the object within the bucket.
    local_path:
        Location on the local filesystem where the file should be stored.
    """

    try:
        client = storage.Client()
        bucket_obj = client.bucket(bucket)
        blob = bucket_obj.blob(filename)
        blob.download_to_filename(local_path)
        logger.info("Downloaded gs://%s/%s to %s", bucket, filename, local_path)
    except Exception:  # pragma: no cover - just log and re-raise
        logger.exception(
            "Failed to download file gs://%s/%s", bucket, filename
        )
        raise


def upload_to_bigquery(dataset: str, table: str, df: pd.DataFrame) -> None:
    """Load a :class:`pandas.DataFrame` into BigQuery.

    The dataset and table must already exist.  This helper simply submits a
    ``load_table_from_dataframe`` job and waits for its completion.
    """

    table_id = f"{dataset}.{table}"
    try:
        client = bigquery.Client()
        job = client.load_table_from_dataframe(df, table_id)
        job.result()  # Wait for the load job to complete.
        logger.info("Uploaded %d rows to %s", len(df), table_id)
    except Exception:  # pragma: no cover - just log and re-raise
        logger.exception("Failed to upload dataframe to %s", table_id)
        raise


__all__ = ["download_from_gcs", "upload_to_bigquery", "get_logger"]

