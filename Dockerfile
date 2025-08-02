FROM python:3.11-slim

# Install system dependencies (for compiling some Python deps like pandas, numpy)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first (better layer caching)
COPY src/gcp_data_pipeline/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ /app/src

# Create non-root user
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Expose FastAPI port
EXPOSE 8080

# Start FastAPI app
CMD ["uvicorn", "gcp_data_pipeline.main:app", "--host", "0.0.0.0", "--port", "8080", "--app-dir", "src"]
