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
quarto render index.qmd

echo "Done."
