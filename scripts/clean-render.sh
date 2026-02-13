#!/usr/bin/env bash
# clean-render.sh — Clear all Quarto caches and re-render the manuscript
#
# Use this when:
#   - Underlying data files changed but notebook source didn't
#   - Embed previews are stale despite source changes
#   - You want a guaranteed clean build
set -euo pipefail
cd "$(dirname "$0")/.."

echo "Cleaning Quarto caches..."
rm -rf _freeze/
rm -rf .quarto/embed/
rm -rf .quarto/_freeze/
rm -f notebooks/*.embed-preview.html
rm -rf notebooks/*.embed_files/

echo "Rendering manuscript..."

# Render REGION PDF separately (requires 4 LaTeX passes with natbib;
# the combined quarto render only runs 2, which drops the REGION template)
echo "  [1/3] REGION journal PDF..."
quarto render index.qmd --to region-ersa/REGION-pdf
# Quarto writes the intermediate LaTeX to index.tex regardless of output-file.
# Rename it now before the standard PDF render overwrites it.
mv index.tex index-REGION.tex

# Render standard PDF separately
echo "  [2/3] Standard PDF..."
quarto render index.qmd --to pdf
# index.tex is now the standard LaTeX source (kept via keep-tex: true)

# Render remaining formats together
echo "  [3/3] HTML, DOCX, JATS..."
quarto render index.qmd --to html --to docx --to jats

# Strip legacy/ from MECA bundle (too large, not needed for replication)
if [ -f index-meca.zip ]; then
  zip -d index-meca.zip "source/legacy/*" 2>/dev/null || true
  zip -d index-meca.zip "source/log/*" 2>/dev/null || true
  echo "  Stripped legacy/ and log/ from MECA bundle."
fi

echo "Done."
