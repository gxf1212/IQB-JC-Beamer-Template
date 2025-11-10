#!/usr/bin/env python3
"""
Extract a specific page from PDF to PNG image for visual debugging.
Usage: python3 tools/extract_pdf_page.py <pdf_path> <page_number> [output_path]
"""

import sys
import os
from pathlib import Path

try:
    from pdf2image import convert_from_path
except ImportError:
    print("Error: pdf2image package not installed. Install with:")
    print("pip install pdf2image")
    print("Also ensure poppler-utils is installed (sudo apt-get install poppler-utils)")
    sys.exit(1)

def extract_pdf_page(pdf_path, page_number, output_path=None):
    """Extract page from PDF and save as PNG."""
    if not Path(pdf_path).exists():
        print(f"Error: PDF file not found: {pdf_path}")
        return False

    if page_number < 1:
        print("Error: Page number must be >= 1")
        return False

    try:
        # Convert PDF to list of images
        images = convert_from_path(pdf_path, first_page=page_number, last_page=page_number)

        if not images:
            print(f"Error: Could not extract page {page_number}")
            return False

        # Get the extracted image
        image = images[0]

        # Determine output path
        if output_path is None:
            output_path = f"/tmp/pdf_page_{page_number}.png"

        # Save the image
        image.save(output_path, 'PNG')
        print(f"Page {page_number} extracted to: {output_path}")
        print(f"Image size: {image.size}")
        return True

    except Exception as e:
        print(f"Error extracting page: {e}")
        return False

def main():
    """Main function."""
    if len(sys.argv) < 3:
        print("Usage: python3 extract_pdf_page.py <pdf_path> <page_number> [output_path]")
        print("Example: python3 extract_pdf_page.py document.pdf 5")
        sys.exit(1)

    pdf_path = sys.argv[1]
    try:
        page_number = int(sys.argv[2])
    except ValueError:
        print("Error: Page number must be an integer")
        sys.exit(1)

    output_path = sys.argv[3] if len(sys.argv) > 3 else None

    success = extract_pdf_page(pdf_path, page_number, output_path)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
