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

To add or modify content in the manuscript:

**Main Source File:** [`index.qmd`](index.qmd)

This is the primary manuscript file where all content should be added or edited. It contains:

- YAML front matter (metadata, author info, keywords, JEL codes)
- Introduction, Methods, Results, and Conclusions sections
- Embedded figures and tables
- References to analysis notebooks

**Compiling the Manuscript:**

After editing `index.qmd`, compile to different formats:

```bash
# REGION journal PDF (for submission)
quarto render index.qmd --to REGION-pdf

# Standard HTML
quarto render index.qmd --to html

# Microsoft Word
quarto render index.qmd --to docx

# All formats
quarto render index.qmd
```

**Important Notes:**

- The compiled outputs are saved in [`_manuscript/`](_manuscript/) directory
- LaTeX source is saved alongside the PDF: [`_manuscript/index.tex`](_manuscript/index.tex)
- Keep `index.qmd` and `_manuscript/index.qmd` synchronized (they should have identical content)
- REGION template is configured for peer review (anonymized author info, line numbers, no watermark)

**Switching Between Review and Final Modes:**

Edit [`_quarto.yml`](_quarto.yml) to change document status:

- `docstatus: review` - For peer review (anonymized, line numbers)
- `docstatus: final` - For publication (full author info, no line numbers)

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

**Last Updated:** February 4, 2026

**Project Status:** Analysis complete, manuscript in progress

**Git Commit:** 9486c04 (add tables)
