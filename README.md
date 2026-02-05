# Spatial Convergence Analysis of Nighttime Lights in India (1996-2010)

A reproducible data science project analyzing regional economic convergence using satellite nighttime light data across 520 Indian administrative districts.

## Overview

This project investigates regional economic convergence in India by analyzing nighttime light (NTL) data from the Defense Meteorological Satellite Program (DMSP) as a proxy for economic activity. Using spatial econometric methods, we examine how initial luminosity levels and neighboring regions' characteristics affect regional growth patterns.

**Key Research Questions:**

- Do Indian regions exhibit β-convergence in nighttime luminosity (1996-2010)?
- How do neighboring regions' luminosity levels influence local growth?
- What spatial spillover effects exist in regional development patterns?

## Data

**Main Dataset:** [`data/india520.dta`](data/india520.dta) (Stata format, 1.2 MB)

- **Observations:** 520 Indian administrative districts
- **Time Period:** 1996-2010
- **Data Source:** DMSP-OLS Nighttime Lights (calibrated via Google Earth Engine)

**Key Variables:**

- `light_growth96_10rcr_cap` - Luminosity growth rate (dependent variable)
- `log_light96_10rcr_cap` - Initial luminosity level (log-transformed)
- `SL_light_growth96_10rcr_cap` - Spatial lag of growth
- `SL_log_light96_10rcr_cap` - Spatial lag of initial luminosity
- **Geographic controls:** Terrain, rainfall, temperature, ruggedness
- **Demographic controls:** Literacy, education, electrification rates
- **Economic controls:** Population density, road infrastructure

**Spatial Weights Matrix:**

- Type: Queen adjacency matrix (row-normalized)
- Dimensions: 520 × 520
- Variable: `WqueenS_fromStata15`

## Methods

### Statistical Approaches

1. **OLS Regression** - Unconditional β-convergence testing
2. **Spatial Durbin Model (SDM)** - Spatial spillover analysis
3. **Fixed Effects Models** - State-level heterogeneity controls
4. **Spatial Dependence Testing** - Moran's I and related diagnostics

### Model Specifications

```text
Growth = β₀ + β₁(Initial Luminosity) + β₂(Spatial Lag Growth) +
         β₃(Spatial Lag Initial) + β₄(Controls) + ε
```

## Project Structure

```text
project2025s/
├── code/                    # Modular code and scripts
├── data/                    # Raw data files
│   └── india520.dta        # Main dataset (520 districts, 1996-2010)
├── docs/                    # Documentation and references
├── figures/                 # Generated visualizations
├── notebooks/              # Analysis notebooks
│   ├── scatterplots.qmd   # Convergence analysis
│   ├── dependence.qmd     # Spatial dependence testing
│   ├── gee_app.qmd        # Google Earth Engine web app
│   └── code_models.ipynb  # Spatial Durbin Models
├── slides/                 # Quarto presentations
├── tables/                 # Generated tables
├── legacy/                 # Original project archive (Archive.zip)
├── log/                    # Progress logs across sessions
├── _manuscript/            # Manuscript outputs (PDF, DOCX)
├── config.py              # Python configuration
├── config.R               # R configuration
├── requirements.txt       # Python dependencies
├── CLAUDE.md              # AI assistant guidelines
└── README.md              # This file
```

## Requirements

### Python Dependencies

Install via `pip install -r requirements.txt`:

**Core packages:**

- numpy==1.26.4
- pandas==2.2.0
- matplotlib==3.8.2
- seaborn==0.13.2
- scikit-learn==1.4.0
- statsmodels==0.14.6
- jupyter==1.0.0

**Geospatial packages:**

- geopandas>=1.1.2
- pysal==24.1
- libpysal==4.9.2
- esda==2.5.1
- mgwr==2.2.1 (Multiscale Geographically Weighted Regression)
- rasterio==1.3.9
- contextily==1.5.0
- mapclassify==2.6.1
- folium>=0.20.0

**Reporting:**

- stargazer==0.0.7 (regression tables)

### R Dependencies

See [`config.R`](config.R) for automatic package installation and setup.

### Other Tools

- **Stata:** For spatial econometric models (optional)
- **Quarto:** For rendering notebooks and presentations
- **Google Earth Engine:** For interactive NTL visualization

## Usage

### Quick Start

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd project2025s
   ```

2. **Install Python dependencies**

   ```bash
   pip install -r requirements.txt
   ```

3. **Run analyses**

   - Open Jupyter notebooks in [`notebooks/`](notebooks/)
   - Render Quarto documents: `quarto render notebooks/scatterplots.qmd`

### Configuration

Both Python and R configurations set:

- `RANDOM_SEED = 42` (reproducibility)
- Automatic directory creation
- Consistent path management across languages

**Python:** Import `config.py` for paths and seed setting

**R:** Source `config.R` for environment setup

### Editing the Manuscript

**Main Source File:** [index.qmd](index.qmd)

This is the primary manuscript file where all content should be added or edited. It contains:

- YAML front matter (metadata, author info, keywords, JEL codes)
- Introduction, Methods, Results, Conclusions sections
- Embedded figures and tables
- References to analysis notebooks

**Quick Compilation Commands:**

```bash
# REGION journal PDF (for submission)
quarto render index.qmd --to REGION-pdf

# HTML for GitHub Pages
quarto render index.qmd --to html

# Microsoft Word
quarto render index.qmd --to docx

# All formats
quarto render index.qmd
```

**For the complete workflow including GitHub Pages publishing and git commits, see the [Publishing Workflow](#publishing-workflow) section below.**

**Important Notes:**

- Compiled outputs are saved in [_manuscript/](_manuscript/) directory
- LaTeX source is saved alongside PDF: [_manuscript/index.tex](_manuscript/index.tex)
- Keep `index.qmd` and `_manuscript/index.qmd` synchronized (they should have identical content)
- REGION template is configured for peer review (anonymized author info, line numbers, no watermark)

**Switching Document Modes:**

Edit [_quarto.yml](_quarto.yml) to change document status:

- `docstatus: review` - For peer review (anonymized, line numbers)
- `docstatus: final` - For publication (full author info, no line numbers)

## Publishing Workflow

This section describes the complete end-to-end workflow for updating manuscript content and publishing changes to both the GitHub Pages website and PDF outputs.

### Overview Diagram

```text
Edit Content → Compile Formats → Update GitHub Pages → Commit & Push
   (index.qmd)   (quarto render)   (update script)      (git commands)
```

### Detailed Workflow

#### Step 1: Edit Manuscript Content

Edit the main manuscript file:

**File:** [index.qmd](index.qmd)

Make your changes to:
- YAML front matter (metadata, authors, keywords)
- Introduction, Methods, Results, Conclusions sections
- Embedded figures and tables
- References and citations

#### Step 2: Compile to Desired Formats

After editing, compile the manuscript to the formats you need.

**For Peer Review Submission (REGION PDF):**

```bash
quarto render index.qmd --to REGION-pdf
```

Output: `_manuscript/index.pdf` (with line numbers, anonymized)

**For GitHub Pages Website (HTML):**

```bash
quarto render index.qmd --to html
```

Output: `_manuscript/index.html` (with dark/light mode, TOC, lightbox)

**For Other Formats:**

```bash
# Microsoft Word
quarto render index.qmd --to docx

# JATS XML (journal archiving format)
quarto render index.qmd --to jats

# All formats at once
quarto render index.qmd
```

All outputs are saved in the [_manuscript/](_manuscript/) directory.

#### Step 3: Update GitHub Pages (If HTML Changed)

After compiling the HTML version, update the live website:

```bash
./update_gh_pages.sh
```

**What this script does:**

1. Copies `_manuscript/index.html` to `docs/index.html`
2. Copies supporting directories:
   - `site_libs/` (Quarto JavaScript and CSS libraries)
   - `index_files/` (plots, figures, supporting files)
   - `images/` (manuscript images)
   - `notebooks/` (notebook preview HTML files)
3. Copies other format files for download:
   - `index.pdf` (standard PDF)
   - `REGION-pdf.pdf` (REGION journal PDF, if compiled)
   - `index.docx` (Microsoft Word)
   - `index.jats` (JATS XML, if compiled)
4. Creates `.nojekyll` file (prevents GitHub from using Jekyll)

**Script Location:** [update_gh_pages.sh](update_gh_pages.sh)

**Destination:** [docs/](docs/) folder (served by GitHub Pages)

#### Step 4: Review Changes

Before committing, review what changed:

```bash
git status
git diff
```

Check the following:

- `index.qmd` - Your content edits
- `_manuscript/index.pdf` - Compiled PDF looks correct
- `_manuscript/index.html` - HTML renders properly
- `docs/index.html` - Website copy is up-to-date

#### Step 5: Commit and Push to GitHub

Stage and commit your changes:

```bash
# Stage the files
git add index.qmd _manuscript/ docs/

# Commit with descriptive message
git commit -m "Update manuscript: [describe your changes]"

# Push to GitHub
git push origin master
```

**Important:** GitHub Pages automatically rebuilds within 1-2 minutes after pushing to the `docs/` folder.

#### Step 6: Verify Live Website

After pushing, wait 1-2 minutes and check the live site:

**URL:** `https://<username>.github.io/project2025s/`

Verify:
- Updated content appears correctly
- All images and figures load
- Notebook links work
- Dark/light mode toggle functions
- No broken links

### Common Workflows

**Workflow 1: Update Website Only**

```bash
# 1. Edit content
vim index.qmd

# 2. Compile HTML
quarto render index.qmd --to html

# 3. Update GitHub Pages
./update_gh_pages.sh

# 4. Commit and push
git add index.qmd docs/ _manuscript/
git commit -m "Update manuscript content"
git push
```

**Workflow 2: Update PDF for Journal Submission**

```bash
# 1. Edit content
vim index.qmd

# 2. Compile REGION PDF
quarto render index.qmd --to REGION-pdf

# 3. Review PDF
open _manuscript/index.pdf

# 4. Commit (no GitHub Pages update needed)
git add index.qmd _manuscript/index.pdf
git commit -m "Update manuscript for journal submission"
git push
```

**Workflow 3: Update All Formats**

```bash
# 1. Edit content
vim index.qmd

# 2. Compile all formats
quarto render index.qmd

# 3. Update GitHub Pages
./update_gh_pages.sh

# 4. Commit everything
git add index.qmd _manuscript/ docs/
git commit -m "Update manuscript - all formats"
git push
```

### Switching Between Review and Final Modes

The REGION PDF template supports two document modes:

**Review Mode (Current):**
- Anonymized author information
- Line numbers for peer review
- No watermark
- Use for: Peer review submission

**Final Mode:**
- Full author metadata and affiliations
- No line numbers
- Professional formatting
- Use for: Final publication

**To Switch Modes:**

Edit [_quarto.yml](_quarto.yml) line 18:

```yaml
# For peer review
docstatus: review

# For publication
docstatus: final
```

Then recompile:

```bash
quarto render index.qmd --to REGION-pdf
```

### Troubleshooting

**Problem: Quarto render fails with LaTeX errors**

- Check for Unicode characters (use `$\beta$` instead of `β`)
- Verify all image paths exist
- Check for unescaped special characters in text

**Problem: GitHub Pages not updating**

- Verify `update_gh_pages.sh` ran successfully
- Check that `docs/` folder is committed and pushed
- Wait 2-3 minutes for GitHub Pages rebuild
- Check GitHub repository settings → Pages → Source is set to "master branch /docs folder"

**Problem: Images not appearing on website**

- Verify images are in `_manuscript/images/` after rendering
- Check that `update_gh_pages.sh` copied `images/` to `docs/`
- Verify image paths in `index.qmd` are correct (should be `images/filename.png`)

**Problem: Notebooks not accessible**

- Verify notebooks are in `_manuscript/notebooks/` after rendering
- Check that `update_gh_pages.sh` copied `notebooks/` to `docs/`
- Ensure notebook files are `.html` format (Quarto generates these from `.qmd`/`.ipynb`)

### GitHub Pages Configuration

**Repository Settings:**

1. Go to repository Settings → Pages
2. Source: Deploy from a branch
3. Branch: `master`
4. Folder: `/docs`
5. Save

**Important Files:**

- `docs/.nojekyll` - Tells GitHub not to process files with Jekyll (created automatically by `update_gh_pages.sh`)
- `docs/index.html` - Main manuscript HTML
- `docs/README.md` - Documentation about the docs folder

### Format-Specific Notes

**REGION-pdf:**
- Output: PDF formatted for European Regional Science Association journal
- LaTeX engine: pdflatex
- Source TeX preserved at: `_manuscript/index.tex`
- Review mode: anonymized, line numbers
- Final mode: full metadata, no line numbers

**HTML:**
- Output: Interactive web version with modern features
- Dark/light mode toggle
- Clickable figures (lightbox)
- Table of contents navigation
- Code copy buttons
- Embedded notebook previews
- Hypothesis annotation system
- Format download links (PDF, DOCX)

**DOCX:**
- Output: Microsoft Word format
- Useful for: Track changes, collaborator comments
- Preserves: Figures, tables, citations

**JATS:**
- Output: Journal Article Tag Suite XML
- Useful for: Journal archiving, repository submission
- Preserves: Full document structure and metadata

## Key Outputs

### Visualizations

Generated in [`figures/`](figures/):

- `fig-convergence-1.png` - Regional luminosity convergence scatter plot
- `fig-dependence1-1.png` - Spatial dependence in growth rates
- `fig-dependence2-1.png` - Spatial dependence in initial levels
- `fig-dependence-combined-1.png` - Combined spatial analysis

### Manuscript

Located in [`_manuscript/`](_manuscript/):

- `index.pdf` (8.4 MB) - Main manuscript
- `index.docx` (9.9 MB) - Word version
- `images/luminosity_map.png` - India luminosity visualization

### Interactive Tools

**Google Earth Engine Web App:**

- URL: <https://carlos-mendez.projects.earthengine.app/view/rc-dmsp-ntl>
- Source: <https://code.earthengine.google.com/87ac51fc81a194c7a1dfa299f3251a95>
- Features: Interactive NTL visualization (1996 vs 2010)

## Reproducibility

### Random Seed

All analyses use `RANDOM_SEED = 42` for reproducibility.

### Legacy Folder

The [`legacy/`](legacy/) folder contains a complete snapshot (Archive.zip, 96.5 MB) of the original project state created on 2026-01-20. This archive is **immutable** and serves as a backup.

### Progress Logs

Session-by-session progress is documented in [`log/`](log/) using timestamped entries (format: `YYYYMMDD_HHMM.md`).

## Repository Rules

**Critical Guidelines (see [CLAUDE.md](CLAUDE.md) for full details):**

1. ❌ **NEVER DELETE DATA** - Protected formats: `.dta`, `.sav`, `.csv`, `.xlsx`, `.shp`, `.db`, `.json`, `.parquet`
2. ❌ **NEVER DELETE PROGRAMS** - Protected formats: `.do`, `.R`, `.py`, `.ipynb`, `.qmd`, `.yaml`, `.md`
3. 📁 **USE LEGACY FOLDER** - Copy from `legacy/` when needed (never modify)
4. 🏠 **STAY WITHIN PROJECT** - All work remains in this directory
5. 📋 **COPY, DON'T MOVE** - Copy files between directories (don't move)
6. 📝 **MAINTAIN LOGS** - Document progress in `log/` with timestamps

## Analysis Workflow

1. **Data Preparation** - Load and clean NTL data from GEE
2. **Exploratory Analysis** - Convergence scatter plots and spatial dependence
3. **Model Estimation** - OLS and Spatial Durbin Models
4. **Diagnostics** - Spatial autocorrelation tests
5. **Interpretation** - Direct and indirect spatial effects
6. **Reporting** - Generate figures, tables, and manuscript

## Key Findings

- **β-Convergence:** Negative relationship between initial luminosity and growth indicates convergence
- **Spatial Spillovers:** Neighboring regions' luminosity significantly affects local growth
- **Model Performance:** SDM specifications outperform OLS (lower AIC)
- **Fixed Effects:** State-level controls improve model fit

## Project Status

**Current State (February 2026):**

- ✅ **Analysis Complete** - All spatial convergence analyses finished
- ✅ **Manuscript Ready** - Formatted for REGION journal peer review submission
- ✅ **GitHub Pages Live** - Interactive HTML version hosted at: `https://<username>.github.io/project2025s/`
- ✅ **Multiple Formats** - PDF, HTML, DOCX, and JATS outputs available

**Manuscript Modes:**

- **Review Mode (Current)** - Anonymized for peer review, includes line numbers, no watermark
- **Final Mode** - Full author metadata, ready for publication

**Next Steps:**

- Submit PDF to REGION journal
- Share GitHub Pages link for interactive exploration
- Prepare revisions based on peer review feedback

## Author

Carlos Mendez - <carlosmendez777@gmail.com>

Repository: project2025s

## Citation

```bibtex
@misc{mendez2025india,
  author = {Mendez, Carlos},
  title = {Spatial Convergence Analysis of Nighttime Lights in India (1996-2010)},
  year = {2025},
  howpublished = {\url{<repository-url>}}
}
```

## License

[Specify license here]

## Acknowledgments

- DMSP-OLS Nighttime Lights data from Google Earth Engine
- Indian district boundary data from geoBoundaries
- Spatial econometric methods from PySAL and R spatial packages

---

**Last Updated:** February 5, 2026

**Git Commit:** 9486c04 (add tables)
