# 🐼 CutePandas

Pre-built Docker image with pandas and data science libraries for MCP (Model Context Protocol) servers.

## Quick Start

```bash
docker pull sagacient/cutepandas:latest
```

## Included Libraries

| Package | Version | Description |
|---------|---------|-------------|
| pandas | 2.2.3 | Data manipulation and analysis |
| numpy | 2.2.2 | Numerical computing |
| scipy | 1.15.1 | Scientific computing |
| scikit-learn | 1.6.1 | Machine learning |
| matplotlib | 3.10.0 | Plotting and visualization |
| seaborn | 0.13.2 | Statistical visualization |
| openpyxl | 3.1.5 | Excel file support (.xlsx) |
| xlrd | 2.0.1 | Excel file support (.xls) |
| pyarrow | 19.0.0 | Parquet file support |
| fastparquet | 2024.11.0 | Fast Parquet support |

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest stable build from main branch |
| `vX.Y.Z` | Specific version release |
| `YYYYMMDD` | Daily build with date |
| `<sha>` | Specific commit build |

## Platforms

- `linux/amd64` (Intel/AMD)
- `linux/arm64` (Apple Silicon, ARM servers)

## Usage with MCP Servers

This image is designed to be used by MCP servers that execute pandas scripts in isolated containers.

```bash
# Run a pandas script
docker run --rm -v /path/to/data:/data:ro sagacient/cutepandas script.py
```

## Security

- Runs as non-root user (`pandas`, UID 1000)
- No network access by default
- Minimal base image (python:3.12-slim)

## Building Locally

```bash
docker build -t cutepandas:latest .
```

## License

[Mozilla Public License 2.0 (MPL-2.0)](LICENSE)
