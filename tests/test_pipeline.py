"""Tests for the ETL pipeline logic.

External calls to Google Cloud services and the :mod:`pandas` dependency are
mocked so that the tests can run in an isolated environment.
"""

from __future__ import annotations

import csv
import sys
import types


# ---------------------------------------------------------------------------
# Provide a very small stub of the :mod:`pandas` API used by the pipeline so
# that the tests do not require the real dependency to be installed.


class _FakeDataFrame:
    def __init__(self, data, columns):
        self._data = data
        self.columns = columns

    def __len__(self):  # pragma: no cover - trivial
        return len(self._data)


def _fake_read_csv(path: str) -> _FakeDataFrame:
    with open(path, newline="") as fh:
        reader = csv.reader(fh)
        rows = list(reader)
    return _FakeDataFrame(rows[1:], rows[0])


sys.modules.setdefault(
    "pandas",
    types.SimpleNamespace(DataFrame=_FakeDataFrame, read_csv=_fake_read_csv),
)

# Stub out google.cloud modules to avoid heavy dependencies during import.
google_module = types.SimpleNamespace()
cloud_module = types.SimpleNamespace(
    bigquery=types.SimpleNamespace(Client=object),
    storage=types.SimpleNamespace(Client=object),
)
google_module.cloud = cloud_module
sys.modules.setdefault("google", google_module)
sys.modules.setdefault("google.cloud", cloud_module)
sys.modules.setdefault("google.cloud.bigquery", cloud_module.bigquery)
sys.modules.setdefault("google.cloud.storage", cloud_module.storage)


from gcp_data_pipeline.pipeline import process_csv  # noqa: E402  (after stubbing)


def _fake_download(bucket: str, filename: str, local_path: str) -> None:
    """Write a small CSV to ``local_path`` mimicking a download."""

    with open(local_path, "w", newline="") as fh:
        writer = csv.writer(fh)
        writer.writerow(["ColA", "ColB"])
        writer.writerow([1, "x"])
        writer.writerow([2, "y"])


def _fake_upload(dataset: str, table: str, df: _FakeDataFrame) -> None:
    """Assert the dataframe looks as expected before "uploading"."""

    assert list(df.columns) == ["cola", "colb"]


def test_process_csv(monkeypatch):
    """Processing a CSV returns a success payload with row count."""

    monkeypatch.setattr("gcp_data_pipeline.pipeline.download_from_gcs", _fake_download)
    monkeypatch.setattr("gcp_data_pipeline.pipeline.upload_to_bigquery", _fake_upload)

    result = process_csv("my-bucket", "data.csv")

    assert result["status"] == "success"
    assert result["rows_processed"] == 2

