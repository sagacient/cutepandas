#!/usr/bin/env python3
"""
Download and cache geo datasets during Docker image build.
This script is executed during the cutepandas image build process.
"""

import sys
import geopandas as gpd
import geodatasets
import requests
from pathlib import Path

def download_geodatasets_cache():
    """Download common geodatasets to cache."""
    print("📦 Downloading geodatasets cache...")
    print("=" * 50)
    
    # List of known geodatasets (as of 2024)
    known_datasets = [
        'naturalearth.land',
        'naturalearth_lowres',
        'naturalearth_cities',
        'nybb',
        'geoda.chicago_commpop',
        'geoda.chicago_health',
        'geoda.guerry',
        'geoda.groceries',
    ]
    
    success_count = 0
    fail_count = 0
    
    for dataset_name in known_datasets:
        try:
            print(f"  Downloading: {dataset_name}...", end=' ', flush=True)
            path = geodatasets.get_path(dataset_name)
            print("✓")
            success_count += 1
        except Exception as e:
            print(f"✗ {e}")
            fail_count += 1
    
    print(f"\n✅ Downloaded {success_count}/{len(known_datasets)} geodatasets")
    if fail_count > 0:
        print(f"⚠️  Failed: {fail_count} datasets")
    print()

def download_sample_geojson():
    """Download sample datasets as GeoJSON."""
    print("📥 Downloading sample datasets...")
    print("=" * 50)
    
    output_dir = Path('/usr/local/share/geo-data/samples')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    samples = [
        ('nybb', 'New York boroughs'),
        ('naturalearth_lowres', 'World countries (low resolution)'),
        ('naturalearth_cities', 'World cities'),
    ]
    
    for name, description in samples:
        try:
            print(f"  📥 {name}: {description}")
            path = geodatasets.get_path(name)
            gdf = gpd.read_file(path)
            
            output_file = output_dir / f'{name}.geojson'
            gdf.to_file(output_file, driver='GeoJSON')
            
            size = output_file.stat().st_size / 1024
            print(f"     ✓ Saved: {len(gdf)} features, {size:.1f} KB\n")
        except Exception as e:
            print(f"     ✗ Failed: {e}\n")
    
    files = list(output_dir.glob('*.geojson'))
    print(f"✅ Created {len(files)} sample files\n")

def download_world_maps():
    """Download world maps from public GeoJSON URLs."""
    print("🗺️  Downloading world maps...")
    print("=" * 50)
    
    output_dir = Path('/usr/local/share/geo-data/world-maps')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    sources = [
        {
            'name': 'world-countries-110m',
            'url': 'https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson',
            'description': 'World countries with ISO codes'
        },
        {
            'name': 'world-countries-detailed',
            'url': 'https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json',
            'description': 'World countries (detailed)'
        },
        {
            'name': 'world-admin-0',
            'url': 'https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_110m_admin_0_countries.geojson',
            'description': 'Natural Earth countries (110m)'
        },
        {
            'name': 'us-states',
            'url': 'https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json',
            'description': 'US States'
        },
        {
            'name': 'world-capitals',
            'url': 'https://raw.githubusercontent.com/icaoberg/csv2geojson/master/data/world-capitals.geojson',
            'description': 'World capital cities'
        },
    ]
    
    success = 0
    failed = 0
    
    for source in sources:
        try:
            name = source['name']
            url = source['url']
            
            print(f"  📥 {name}...", end=' ', flush=True)
            gdf = gpd.read_file(url)
            
            output_file = output_dir / f'{name}.geojson'
            gdf.to_file(output_file, driver='GeoJSON')
            
            size = output_file.stat().st_size / (1024 * 1024)
            print(f"✓ {len(gdf)} features, {size:.2f} MB")
            success += 1
            
        except Exception as e:
            print(f"✗ {e}")
            failed += 1
    
    print(f"\n✅ Downloaded {success}/{len(sources)} world maps")
    if failed > 0:
        print(f"⚠️  Failed: {failed}")
    print()

def main():
    """Main function to download all geo data."""
    print("\n🌍 Geo Data Download for CutePandas Image")
    print("=" * 50)
    print()
    
    try:
        # Step 1: Download geodatasets cache
        download_geodatasets_cache()
        
        # Step 2: Download sample datasets as GeoJSON
        download_sample_geojson()
        
        # Step 3: Download world maps
        download_world_maps()
        
        print("🎉 All geo data downloaded successfully!")
        print("\nData locations:")
        print("  • Geodatasets cache: ~/.cache/geodatasets")
        print("  • Sample datasets: /usr/local/share/geo-data/samples")
        print("  • World maps: /usr/local/share/geo-data/world-maps")
        print()
        
        return 0
        
    except Exception as e:
        print(f"\n❌ Error during download: {e}", file=sys.stderr)
        return 1

if __name__ == '__main__':
    sys.exit(main())
