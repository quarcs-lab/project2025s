# GitHub Pages - Manuscript HTML

This directory contains the HTML version of the manuscript for hosting on GitHub Pages.

## Contents

- `index.html` - Main manuscript HTML (copied from `_manuscript/index.html`)
- `site_libs/` - Quarto JavaScript and CSS libraries
- `index_files/` - Supporting files for the HTML (plots, figures)
- `images/` - Manuscript images
- `notebooks/` - Notebook preview HTML files (for interactive exploration)
- `.nojekyll` - Prevents GitHub from processing files with Jekyll

## Updating This Site

Whenever you regenerate the manuscript, run the update script from the project root:

```bash
./update_gh_pages.sh
```

This script will automatically copy the latest HTML and supporting files from `_manuscript/` to `docs/`.

## Source

The content in this folder is automatically generated from:

- Source file: `index.qmd`
- Build directory: `_manuscript/`
- Build command: `quarto render index.qmd --to html`

**Do not edit files in this directory directly.** All edits should be made to `index.qmd` and then regenerated.

---

**Generated:** February 5, 2026
**Project:** Spatial Convergence Analysis of Nighttime Lights in India
