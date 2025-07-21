# ----- Stage 1: Build dependencies -----
FROM python:3.12-slim AS builder

# Set work directory and disable bytecode generation
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# System dependencies for build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies in a temporary directory
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# ----- Stage 2: Runtime container -----
FROM python:3.12-slim

WORKDIR /app

# Install only necessary runtime dependencies
COPY --from=builder /wheels /wheels
COPY requirements.txt .
RUN pip install --no-cache /wheels/*

# Copy source code
COPY . .

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser /app
USER appuser

# Garantit que main.py ne démarre qu’après que PostgreSQL (db:5432) accepte les connexions.
COPY scripts/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh


# Default command (replace with your actual entry point)
CMD ["/wait-for-it.sh", "db:5432", "--", "python", "app/main.py"]
# Garantit que main.py ne démarre qu’après que PostgreSQL (db:5432) accepte les connexions.

