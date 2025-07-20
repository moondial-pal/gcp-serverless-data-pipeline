# 🐍 Minimal base image
FROM python:3.11-slim

# 🛠️ Install system dependencies only once (for caching)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 📦 Install UV globally
RUN pip install uv

# 📁 Set working directory
WORKDIR /app

# 📦 Copy dependency files first (for layer caching)
COPY pyproject.toml uv.lock ./

# 🏗️ Install Python dependencies
RUN uv pip install --system

# 📁 Copy app source code
COPY src/ .

# 👤 Use non-root user for security
RUN adduser --disabled-password appuser && chown -R appuser /app
USER appuser

# 🔥 Expose FastAPI port
EXPOSE 8080

# 🚀 Start FastAPI app with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]

