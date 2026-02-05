#!/bin/bash

# Update GitHub Pages - Copy manuscript HTML to docs/ folder
# This script copies the generated HTML and supporting files from _manuscript/ to docs/
# for GitHub Pages hosting

echo "Updating GitHub Pages documentation..."

# Create docs directory if it doesn't exist
mkdir -p docs

# Copy main HTML file
echo "  Copying index.html..."
cp _manuscript/index.html docs/index.html

# Copy supporting directories
echo "  Copying site_libs/..."
cp -r _manuscript/site_libs docs/

echo "  Copying index_files/..."
cp -r _manuscript/index_files docs/

echo "  Copying images/..."
cp -r _manuscript/images docs/

echo "  Copying notebooks/..."
cp -r _manuscript/notebooks docs/

# Copy other format files for download links
echo "  Copying other format files (PDF, DOCX, JATS)..."
if [ -f _manuscript/index.pdf ]; then
    cp _manuscript/index.pdf docs/index.pdf
fi
if [ -f _manuscript/REGION-pdf.pdf ]; then
    cp _manuscript/REGION-pdf.pdf docs/REGION-pdf.pdf
fi
if [ -f _manuscript/index.docx ]; then
    cp _manuscript/index.docx docs/index.docx
fi
if [ -f _manuscript/index.jats ]; then
    cp _manuscript/index.jats docs/index.jats
fi

# Create .nojekyll file to prevent Jekyll processing
echo "  Creating .nojekyll file..."
touch docs/.nojekyll

echo "✓ GitHub Pages documentation updated successfully!"
echo ""
echo "Next steps:"
echo "  1. Review changes: git status"
echo "  2. Commit changes: git add docs/ && git commit -m 'Update GitHub Pages'"
echo "  3. Push to GitHub: git push"
echo "  4. Configure GitHub Pages to serve from /docs folder (if not already done)"
