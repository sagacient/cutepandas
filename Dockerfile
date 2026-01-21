# CutePandas - Pre-built pandas execution environment for MCP servers
# https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/cutepandas

FROM python:3.12-slim

LABEL org.opencontainers.image.title="CutePandas"
LABEL org.opencontainers.image.description="Pre-built pandas execution environment for MCP servers"
LABEL org.opencontainers.image.source="https://github.com/YOUR_GITHUB_USERNAME/cutepandas"
LABEL org.opencontainers.image.licenses="MPL-2.0"

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies for some Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages (latest stable versions as of Jan 2026)
RUN pip install --no-cache-dir \
    pandas==2.2.3 \
    numpy==2.2.2 \
    openpyxl==3.1.5 \
    xlrd==2.0.1 \
    pyarrow==19.0.0 \
    fastparquet==2024.11.0 \
    scipy==1.15.1 \
    scikit-learn==1.6.1 \
    matplotlib==3.10.0 \
    seaborn==0.13.2

# Create non-root user for security
RUN useradd -m -s /bin/bash -u 1000 pandas

# Create directories
RUN mkdir -p /data /output && \
    chown -R pandas:pandas /data /output

# Switch to non-root user
USER pandas

# Set working directory
WORKDIR /home/pandas

# Default command
ENTRYPOINT ["python"]
