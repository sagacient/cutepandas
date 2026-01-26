# 🐼 CutePandas

Comprehensive Docker image with pandas, data science, NLP, GIS, computer vision, and document processing libraries for MCP (Model Context Protocol) servers.

## Quick Start

```bash
docker pull sagacient/cutepandas:latest
```

## 📦 Included Libraries

### Data Science & Analytics
| Package | Version | Description |
|---------|---------|-------------|
| pandas | 2.2.3 | Data manipulation and analysis |
| numpy | 2.2.2 | Numerical computing |
| scipy | 1.15.1 | Scientific computing |
| scikit-learn | 1.6.1 | Machine learning |
| matplotlib | 3.10.0 | Plotting and visualization |
| seaborn | 0.13.2 | Statistical visualization |
| tabulate | 0.9.0 | Pretty-print tabular data |

### Document Processing
| Package | Version | Description |
|---------|---------|-------------|
| openpyxl | 3.1.5 | Excel files (.xlsx) |
| xlrd | 2.0.1 | Legacy Excel files (.xls) |
| pyarrow | 19.0.0 | Parquet files |
| fastparquet | 2024.11.0 | Fast Parquet support |
| python-docx | 1.1.2 | Word documents (.docx) |
| pypdf | 5.1.0 | PDF documents |
| python-pptx | 1.0.2 | PowerPoint presentations |
| odfpy | 1.4.1 | OpenDocument formats |
| beautifulsoup4 | 4.12.3 | HTML/XML parsing |
| lxml | 5.3.0 | Fast XML/HTML processing |
| pyyaml | 6.0.2 | YAML files |
| toml | 0.10.2 | TOML files |
| markdown | 3.7 | Markdown parsing |
| chardet | 5.2.0 | Character encoding detection |

### Image Processing & Computer Vision
| Package | Version | Description |
|---------|---------|-------------|
| Pillow | 11.0.0 | Image processing |
| opencv-python-headless | 4.10.0.84 | Computer vision (no GUI) |
| pytesseract | 0.3.13 | OCR - text extraction from images |
| pdf2image | 1.17.0 | Convert PDFs to images |
| scikit-image | 0.24.0 | Advanced image algorithms |
| imageio | 2.36.1 | Image I/O operations |

### Mathematics & Symbolic Computing
| Package | Version | Description |
|---------|---------|-------------|
| sympy | 1.13.3 | Symbolic mathematics |
| mpmath | 1.3.0 | Arbitrary-precision arithmetic |
| pylatexenc | 2.10 | LaTeX expression parsing |

### Natural Language Processing (NLP)
| Package | Version | Description |
|---------|---------|-------------|
| spacy | 3.8.3 | Industrial-strength NLP |
| nltk | 3.9.1 | Natural Language Toolkit |
| textblob | 0.18.0 | Simple NLP API |
| langdetect | 1.0.9 | Language detection (55+ languages) |
| gensim | 4.3.3 | Topic modeling & word embeddings |
| rapidfuzz | 3.10.1 | Fast fuzzy string matching |
| ftfy | 6.3.1 | Fix broken Unicode text |
| unidecode | 1.3.8 | ASCII transliteration |
| regex | 2024.11.6 | Advanced regex support |
| textstat | 0.7.4 | Text readability statistics |
| wordcloud | 1.9.4 | Word cloud generation |
| emoji | 2.14.0 | Emoji processing |
| polyglot | 16.7.4 | Multilingual NLP |

**Pre-downloaded NLP Models:**
- spaCy English model (`en_core_web_sm`)
- NLTK popular datasets (stopwords, punkt, wordnet, etc.)
- TextBlob corpora

### Geospatial & GIS
| Package | Version | Description |
|---------|---------|-------------|
| geopandas | 1.0+ | Spatial/geographic data operations |
| shapely | 2.0+ | Geometric operations |
| pyproj | 3.7+ | Coordinate system transformations |
| geodatasets | 2023.12+ | Example geospatial datasets |
| geopy | 2.4+ | Geocoding services |
| folium | 0.18+ | Interactive Leaflet maps |
| contextily | 1.6+ | Basemaps for plots |
| rtree | 1.3+ | Spatial indexing |
| h3 | 3.7+ | Hexagonal hierarchical indexing |
| geojson | 3.1+ | GeoJSON encoding/decoding |
| pygeohash | 1.2+ | Geohash encoding |
| haversine | 2.8+ | Distance calculations |

## ✨ Key Features

- 📊 **Complete Data Science Stack** - pandas, numpy, scipy, scikit-learn, matplotlib, seaborn
- 📄 **Universal Document Support** - Excel, Word, PDF, PowerPoint, HTML, XML, Markdown, YAML
- 🖼️ **Image & Vision** - OpenCV, OCR (Tesseract), PIL, scikit-image
- 🧮 **Mathematical Computing** - SymPy, LaTeX parsing, arbitrary precision
- 🗣️ **Natural Language Processing** - spaCy, NLTK, sentiment analysis, language detection
- 🗺️ **Geospatial Analysis** - GeoPandas, coordinate transformations, interactive maps
- 🔍 **Text Analysis** - Fuzzy matching, Unicode fixing, readability stats, word clouds
- 🚀 **Production Ready** - Multi-platform support, security hardened, pre-downloaded models

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

## Usage Examples

### Basic Usage with MCP Servers

This image is designed to be used by MCP servers that execute pandas scripts in isolated containers.

```bash
# Run a pandas script
docker run --rm -v /path/to/data:/data:ro sagacient/cutepandas script.py
```

### Data Analysis
```bash
# Analyze a CSV file
docker run --rm -v $(pwd):/data:ro sagacient/cutepandas -c "
import pandas as pd
df = pd.read_csv('/data/sales.csv')
print(df.describe())
"
```

### OCR from Image
```bash
# Extract text from image
docker run --rm -v $(pwd):/data:ro sagacient/cutepandas -c "
import pytesseract
from PIL import Image
img = Image.open('/data/document.png')
text = pytesseract.image_to_string(img)
print(text)
"
```

### Geospatial Analysis
```bash
# Process geographic data
docker run --rm -v $(pwd):/data:ro sagacient/cutepandas -c "
import geopandas as gpd
gdf = gpd.read_file('/data/locations.geojson')
print(gdf.to_crs(epsg=3857).head())
"
```

## 🔒 Security

- Runs as non-root user (`pandas`, UID 1000)
- No network access by default
- Minimal base image (python:3.12-slim)
- System dependencies kept to minimum necessary
- Regular updates with latest stable package versions

## 🛠️ System Dependencies

Pre-installed system packages for full library support:
- **GDAL** - Geospatial Data Abstraction Library
- **Tesseract OCR** - Optical character recognition engine
- **Poppler** - PDF rendering utilities
- **PROJ/GEOS** - Cartographic projections and geometry engine
- **OpenGL/Mesa** - Graphics libraries for OpenCV
- **ICU** - Unicode and internationalization support

## Building Locally

```bash
docker build -t cutepandas:latest .
```

## Use Cases

- 📊 Data analysis and transformation pipelines
- 📈 Statistical analysis and machine learning
- 📄 Document processing and extraction
- 🗺️ Geospatial data analysis and mapping
- 🔍 Text mining and NLP tasks
- 🖼️ Image processing and OCR
- 📊 Business intelligence and reporting
- 🧪 Scientific computing and research

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

[Mozilla Public License 2.0 (MPL-2.0)](LICENSE)
