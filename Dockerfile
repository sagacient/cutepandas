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
    g++ \
    tesseract-ocr \
    tesseract-ocr-eng \
    poppler-utils \
    libgl1 \
    libglib2.0-0 \
    libicu-dev \
    libgomp1 \
    gdal-bin \
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libspatialindex-dev \
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
    seaborn==0.13.2 \
    tabulate==0.9.0 \
    python-docx==1.1.2 \
    pypdf==5.1.0 \
    python-pptx==1.0.2 \
    beautifulsoup4==4.12.3 \
    lxml==5.3.0 \
    Pillow==11.0.0 \
    chardet==5.2.0 \
    odfpy==1.4.1 \
    pyyaml==6.0.2 \
    toml==0.10.2 \
    markdown==3.7 \
    opencv-python-headless==4.10.0.84 \
    pytesseract==0.3.13 \
    pdf2image==1.17.0 \
    scikit-image==0.24.0 \
    imageio==2.36.1 \
    sympy==1.13.3 \
    mpmath==1.3.0 \
    pylatexenc==2.10 \
    spacy==3.8.3 \
    nltk==3.9.1 \
    textblob==0.18.0 \
    langdetect==1.0.9 \
    gensim==4.3.3 \
    rapidfuzz==3.10.1 \
    ftfy==6.3.1 \
    unidecode==1.3.8 \
    regex==2024.11.6 \
    textstat==0.7.4 \
    wordcloud==1.9.4 \
    emoji==2.14.0 \
    polyglot==16.7.4 \
    geopandas==1.0.1 \
    shapely==2.0.6 \
    fiona==1.10.1 \
    pyproj==3.7.0 \
    geopy==2.4.1 \
    folium==0.18.0 \
    contextily==1.6.2 \
    rtree==1.3.0 \
    h3==3.7.7 \
    geojson==3.1.0 \
    pygeohash==1.2.0 \
    haversine==2.8.1

# Download common NLP models and data
RUN python -m spacy download en_core_web_sm && \
    python -m nltk.downloader -d /usr/local/share/nltk_data popular && \
    python -m textblob.download_corpora

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
