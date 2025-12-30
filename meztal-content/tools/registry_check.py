#!/usr/bin/env python3
"""
Registry Check Tool
Checks MASTER_REGISTRY.json for duplicate content before creation.
"""

import json
import sys
import re
from pathlib import Path

REGISTRY_PATH = Path("/Users/georgegayl/Desktop/Meztal/MASTER_REGISTRY.json")

def load_registry():
    """Load the master registry."""
    if not REGISTRY_PATH.exists():
        print(f"ERROR: Registry not found at {REGISTRY_PATH}")
        sys.exit(1)
    
    with open(REGISTRY_PATH) as f:
        return json.load(f)

def check_keyword(keyword: str, registry: dict) -> list:
    """Check if keyword exists in registry."""
    matches = []
    keyword_lower = keyword.lower()
    
    # Check url_to_file mapping
    for url, filepath in registry.get("url_to_file", {}).items():
        if keyword_lower in url.lower() or keyword_lower in filepath.lower():
            matches.append({
                "type": "url",
                "url": url,
                "file": filepath
            })
    
    return matches

def check_slug(slug: str, registry: dict) -> list:
    """Check if URL slug exists."""
    matches = []
    slug_normalized = slug.strip("/").lower()
    
    for url in registry.get("url_to_file", {}).keys():
        url_normalized = url.strip("/").lower()
        if slug_normalized == url_normalized or slug_normalized in url_normalized:
            matches.append({
                "type": "slug",
                "url": url,
                "file": registry["url_to_file"][url]
            })
    
    return matches

def main():
    if len(sys.argv) < 3:
        print("Usage: registry_check.py <keyword|slug> <search_term>")
        print("Examples:")
        print("  registry_check.py keyword 'peo services'")
        print("  registry_check.py slug '/services/peo/'")
        sys.exit(1)
    
    check_type = sys.argv[1]
    search_term = sys.argv[2]
    
    registry = load_registry()
    
    if check_type == "keyword":
        matches = check_keyword(search_term, registry)
    elif check_type == "slug":
        matches = check_slug(search_term, registry)
    else:
        print(f"Unknown check type: {check_type}")
        sys.exit(1)
    
    if matches:
        print(f"⚠️  DUPLICATE FOUND for '{search_term}':")
        for match in matches:
            print(f"   URL: {match['url']}")
            print(f"   File: {match['file']}")
            print()
        sys.exit(1)
    else:
        print(f"✅ No duplicates found for '{search_term}'")
        sys.exit(0)

if __name__ == "__main__":
    main()
