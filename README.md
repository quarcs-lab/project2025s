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
├── docs/                    # Documentation and reference files
├── figures/                 # Generated visualizations
├── notebooks/              # Analysis notebooks (QMD and Jupyter)
│   ├── scatterplots.qmd   # Convergence analysis
│   ├── dependence.qmd     # Spatial dependence testing
│   ├── gee_app.qmd        # Google Earth Engine web app
│   └── code_models.ipynb  # Spatial Durbin Models
├── slides/                 # Quarto presentations
├── tables/                 # Generated tables
├── legacy/                 # Original project archive (Archive.zip)
├── log/                    # Progress logs across sessions
├── index.qmd              # Main manuscript source
├── index.html             # Manuscript HTML (GitHub Pages)
├── index.pdf              # Manuscript PDF (REGION format)
├── index.docx             # Manuscript MS Word format
├── index.xml              # Manuscript JATS XML format
├── site_libs/             # Quarto web dependencies
├── index_files/           # Supporting files (plots, figures)
├── images/                # Manuscript images
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

## Workflow

This project follows a simplified, transparent workflow for open science.

### 1. Edit Content

Edit the main manuscript file: [index.qmd](index.qmd)

Make your changes to:
- YAML front matter (metadata, authors, keywords, JEL codes)
- Introduction, Methods, Results, Conclusions sections
- Embedded figures and tables
- References and citations

### 2. Render Manuscript

Compile all formats with a single command:

```bash
quarto render index.qmd
```

This generates all outputs directly in the repository root:
- **`index.html`** - Web version (served by GitHub Pages)
- **`index.pdf`** - REGION journal PDF format
- **`index.docx`** - Microsoft Word format
- **`index.xml`** - JATS XML format
- **`site_libs/`** - Quarto web dependencies
- **`index_files/`** - Supporting files (plots, figures)
- **`images/`** - Manuscript images
- **`notebooks/`** - Notebook HTML previews

**Optional: Render specific formats**

```bash
# REGION journal PDF only
quarto render index.qmd --to REGION-pdf

# HTML only
quarto render index.qmd --to html

# MS Word only
quarto render index.qmd --to docx
```

### 3. Commit and Push

```bash
# Stage all changes
git add index.qmd index.html index.pdf index.docx index.xml site_libs/ index_files/ images/ notebooks/

# Commit with descriptive message
git commit -m "Update manuscript: [describe changes]"

# Push to GitHub
git push
```

**GitHub Pages automatically updates within 1-2 minutes.**

### 4. View Live Website

Visit: **[https://quarcs-lab.github.io/project2025s/](https://quarcs-lab.github.io/project2025s/)**

All files are public and accessible for transparent, reproducible science.

### Document Modes

The REGION PDF template supports two document modes. Edit [_quarto.yml](_quarto.yml) line 18:

```yaml
# For peer review (anonymized, line numbers)
docstatus: review

# For publication (full metadata, no line numbers)
docstatus: final
```

Then recompile: `quarto render index.qmd --to REGION-pdf`

## Key Outputs

### Visualizations

Generated in [`figures/`](figures/):

- `fig-convergence-1.png` - Regional luminosity convergence scatter plot
- `fig-dependence1-1.png` - Spatial dependence in growth rates
- `fig-dependence2-1.png` - Spatial dependence in initial levels
- `fig-dependence-combined-1.png` - Combined spatial analysis

### Manuscript

All manuscript outputs are in the repository root:

- [index.html](index.html) - Interactive web version (GitHub Pages)
- [index.pdf](index.pdf) - REGION journal PDF (12 MB)
- [index.docx](index.docx) - Microsoft Word version (9.4 MB)
- [index.xml](index.xml) - JATS XML format
- [images/luminosity_map.png](images/luminosity_map.png) - India luminosity visualization

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
- ✅ **GitHub Pages Live** - Interactive HTML version hosted at: [https://quarcs-lab.github.io/project2025s/](https://quarcs-lab.github.io/project2025s/)
- ✅ **Multiple Formats** - PDF, HTML, DOCX, and JATS outputs available

**Manuscript Modes:**

- **Review Mode (Current)** - Anonymized for peer review, includes line numbers, no watermark
- **Final Mode** - Full author metadata, ready for publication

**Next Steps:**

- Submit PDF to REGION journal
- Share GitHub Pages link for interactive exploration
- Prepare revisions based on peer review feedback

## Authors

- **Carlos Mendez** (Corresponding) - <carlosmendez777@gmail.com> - Nagoya University
- **Sujana Kabiraj** - Shiv Nadar University
- **Jiaqi Li** - Nagoya University

Repository: [https://github.com/quarcs-lab/project2025s](https://github.com/quarcs-lab/project2025s)

## Citation

```bibtex
@misc{mendez2026india,
  author = {Mendez, Carlos and Kabiraj, Sujana and Li, Jiaqi},
  title = {Spatial Convergence Analysis of Nighttime Lights in India (1996-2010)},
  year = {2026},
  howpublished = {\url{https://github.com/quarcs-lab/project2025s}}
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
