"""ETL pipeline logic for processing CSV files.

The :func:`process_csv` function orchestrates downloading a CSV from Cloud
Storage, performing a very small transformation using :mod:`pandas` and
loading the result into BigQuery.
"""

from __future__ import annotations

import os
from typing import Dict

import pandas as pd
from decouple import config

from gcp_data_pipeline.utils import (
    download_from_gcs,
    get_logger,
    upload_to_bigquery,
)


logger = get_logger(__name__)


def _transform(df: pd.DataFrame) -> pd.DataFrame:
    """Apply a simple transformation to the dataframe.

    Currently this just normalises column names to lower case and strips any
    surrounding whitespace.  This is intentionally small but serves as an
    example of where more complex business logic would live.
    """

    df.columns = [c.strip().lower() for c in df.columns]
    return df


def process_csv(bucket: str, filename: str) -> Dict[str, str | int]:
    """Process ``filename`` from ``bucket`` and load into BigQuery.

    The BigQuery destination dataset and table are read from the environment
    variables ``BIGQUERY_DATASET`` and ``BIGQUERY_TABLE``.  Defaults are
    provided to make local testing easier.
    """

    local_path = os.path.join("/tmp", filename)
    try:
        logger.info("Starting processing for gs://%s/%s", bucket, filename)
        os.makedirs(os.path.dirname(local_path), exist_ok=True)
        download_from_gcs(bucket, filename, local_path)

        df = pd.read_csv(local_path)
        df = _transform(df)

        dataset = config("BIGQUERY_DATASET", default="dataset")
        table = config("BIGQUERY_TABLE", default="table")
        upload_to_bigquery(dataset, table, df)

        return {
            "bucket": bucket,
            "filename": filename,
            "rows_processed": len(df),
            "status": "success",
        }
    except Exception:
        logger.exception(
            "Failed processing for file gs://%s/%s", bucket, filename
        )
        raise
    finally:
        if os.path.exists(local_path):
            try:
                os.remove(local_path)
            except OSError:
                logger.warning("Could not remove temporary file %s", local_path)


__all__ = ["process_csv"]

