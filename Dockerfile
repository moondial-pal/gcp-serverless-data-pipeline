FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy dependency files
COPY src/gcp_data_pipeline/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY src/ .

# Non-root user
RUN adduser --disabled-password appuser && chown -R appuser /app
USER appuser

# Expose FastAPI port
EXPOSE 8080

# Start FastAPI app
CMD ["uvicorn", "gcp_data_pipeline.main:app", "--host", "0.0.0.0", "--port", "8080"]

