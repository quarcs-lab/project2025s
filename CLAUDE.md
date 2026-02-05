# CLAUDE.md – AI Assistant Instructions

**READ THIS FILE FIRST** upon entering this project.

This file contains critical rules and context for working on this project. These rules are non-negotiable.

---

## Critical Rules

### 1. NEVER DELETE DATA

Under no circumstances are you ever to DELETE any data files. Protected formats include:

- **Statistical data:** `.dta`, `.sav`, `.sas7bdat`
- **Spreadsheets:** `.xlsx`, `.xls`, `.csv`, `.tsv`
- **Spatial data:** `.shp`, `.geojson`, `.kml`, `.gpkg`
- **Databases:** `.db`, `.sqlite`, `.sql`
- **Raw data:** `.txt`, `.json`, `.xml`, `.parquet`
- **Add other formats as needed for your project**

### 2. NEVER DELETE PROGRAMS

Under no circumstances are you ever to DELETE any program files. Protected formats include:

- **Scripts:** `.do`, `.R`, `.py`, `.jl`, `.m`
- **Notebooks:** `.ipynb`, `.Rmd`, `.qmd`
- **Configuration:** `.yaml`, `.yml`, `.toml`, `.ini`
- **Documentation:** `.md`, `.tex`
- **Add other formats as needed for your project**

### 3. USE THE LEGACY FOLDER

The `./legacy/` folder contains a complete snapshot of the original project structure (created 20260120). This is sacred and should never be modified.

**One-Time Exception (COMPLETED):** On 20260120, we performed a one-time move of all original files into `./legacy/` to preserve the original project state. This was the only permitted "move" operation.

**Going forward:**

- NEVER move files directly between working directories
- ALWAYS copy from `./legacy/` when you need original files
- If reorganizing, copy files to new locations (never move)

### 4. STAY WITHIN THIS DIRECTORY

Under no circumstances are you ever to GO UP OUT OF THIS ONE FOLDER. All work must remain within this project directory.

### 5. COPY, DON'T MOVE

When working with files:

- COPY from `./legacy/` to working directories
- COPY between working directories if needed
- NEVER move files (except the one-time legacy migration, now complete)

### 6. MAINTAIN PROGRESS LOGS

The `./log/` directory contains progress logs that preserve conversation context across sessions.

**Why:** Chat sessions can die unexpectedly. When a new Claude starts, it has no memory of previous work. Logs bridge this gap.

**When to log:**

- After completing significant work
- Before ending a session
- After major decisions
- When context is building up

**What to include:**

- Current state of the project
- Summary of work done (include key results, tables, or figures)
- Key decisions made
- Any issues or blockers
- Next steps planned

**How:** Create timestamped entries (`YYYYMMDD_HHMM.md`) documenting what was done, current state, and next steps.

**On startup:** Always check `./log/` for recent entries to understand what was happening before.

---

## Project Context

- **Project Title:** Spatial Convergence Analysis of Nighttime Lights in India (1996-2010)
- **Project Directory:** `/Users/carlosmendez/Documents/GitHub/project2025s`
- **Legacy Directory:** `./legacy/`
- **Log Directory:** `./log/`
- **Primary Tools:** Quarto, Python, R, Stata, Claude Code
- **Authors:** Carlos Mendez, Sujana Kabiraj, Jiaqi Li
- **Primary Goal:** **Reproducible research using Quarto's single-source publishing paradigm**

### Core Reproducibility Principles

**This project exemplifies reproducible research through:**

1. **Single-Source Authoring**

   - User writes in **ONE file**: `index.qmd` (main manuscript)
   - Quarto automatically generates **multiple outputs** from this single source:
     - `index.pdf` - Standard PDF (Letter, KOMA-Script, numeric citations)
     - `index-REGION.pdf` - REGION journal PDF (A4, author-year citations, line numbers)
     - `index.html` - Interactive web version (GitHub Pages)
     - `index.docx` - Microsoft Word format
     - `index.xml` - JATS XML format
   - Each format optimized for its purpose (submission, web, collaboration)

2. **Computational Transparency**

   - **All analyses** documented in computational notebooks: `notebooks/`
   - **Interactive HTML manuscript** links directly to executable notebooks
   - **Readers can verify** every figure, table, and result
   - **Complete chain**: Raw data → Code → Results → Publication

3. **Open Science Workflow**

   - All outputs publicly accessible on GitHub
   - GitHub Pages hosts interactive HTML version
   - Computational notebooks embedded and linked
   - No proprietary formats required for access

### Understanding the Workflow

**The user's workflow is intentionally simple:**

```text
Edit index.qmd → Run "quarto render" → All outputs generated automatically
```

**DO NOT complicate this workflow.** The simplicity is intentional and supports reproducibility.

### When Compilation Errors Occur

#### FIRST STEP: Check the latest online Quarto documentation

Before attempting fixes or troubleshooting:

1. **Consult Quarto documentation** at <https://quarto.org/docs/>
   - Quarto is actively developed and documentation is frequently updated
   - Latest online docs may contain fixes for recent issues
   - Check the specific format documentation (PDF, HTML, extensions, etc.)

2. **Search Quarto GitHub Issues** at <https://github.com/quarto-dev/quarto-cli/issues>
   - Many common errors have been reported and resolved
   - Check for known issues with your Quarto version
   - Look for workarounds or solutions from the community

3. **Verify Quarto version**:

   ```bash
   quarto --version
   # Update if needed: quarto update
   ```

4. **Only after consulting documentation**, proceed with project-specific troubleshooting

This approach prevents wasted effort on issues already solved in newer Quarto versions or documented online.

---

## About the Slides Folder

The `slides/` folder contains Quarto presentations created to showcase the results of the current session or specific analyses.

**Design Principles:**
- Clean, professional design suitable for academic or professional presentations
- Effective communication of data analysis findings
- Clear interpretation of results

**Style Guide:**
- **Titles:** Blue (#2874A6)
- **Bold emphasis:** Green (#229954)
- Custom CSS embedded directly in `.qmd` files for easy portability

**Typical Structure:**
```yaml
---
title: "Your Analysis Title"
author: "Your Name"
format:
  revealjs:
    theme: simple
    css: custom.css
---
```

---

## Quarto Extension Troubleshooting

This project uses the REGION journal extension for PDF formatting. Extension issues can be subtle and hard to diagnose. Follow these guidelines to prevent and fix template application problems.

### Understanding Quarto Extensions

**Key Concept:** Extension format identifiers are NOT always obvious from directory structure.

- **Extension directory**: `_extensions/region-ersa/REGION/`
- **Format identifier**: `region-ersa/REGION-pdf` (NOT `region-ersa/REGION/pdf` or `region-ersa/pdf`)
- **Why**: Extensions define custom format names in `_extension.yml` under `contributes.formats:`

### Verifying Correct Format Identifier

Before modifying `_quarto.yml`, always check the extension's format definition:

```bash
# Check what formats the extension contributes
cat _extensions/region-ersa/REGION/_extension.yml | grep -A10 "contributes"

# Look for the format names under "formats:"
# These names are what you use in _quarto.yml
```

**Example from REGION extension:**
```yaml
contributes:
  formats:
    pdf:        # This means use "region-ersa/REGION-pdf" NOT "region-ersa/pdf"
      documentclass: article
      ...
```

### Diagnosing Template Application Issues

**Problem:** PDFs compile successfully but template features are missing (no line numbers, wrong citation style, no branding)

**Silent Fallback:** When Quarto can't find the specified format, it silently falls back to a default format without clear error messages.

**Diagnostic Checklist:**

1. **Check compilation logs for bibliography style:**

   ```bash
   quarto render index.qmd --to region-ersa/REGION-pdf 2>&1 | grep "bst"
   # Should show: region.bst being used
   ```

2. **Count LaTeX compilation passes:**

   ```bash
   quarto render index.qmd --to region-ersa/REGION-pdf 2>&1 | grep "lualatex"
   # REGION uses 4 passes, standard uses 2
   ```

3. **Verify LaTeX source has template packages:**

   ```bash
   # First enable keep-tex in _quarto.yml
   grep "usepackage{region}" index.tex
   # Should show: \usepackage{region,hyperref,multirow}
   ```

4. **Check documentclass in LaTeX source:**

   ```bash
   grep "documentclass" index.tex
   # REGION: \documentclass[a4paper, twoside, review]{article}
   # Standard: \documentclass[...]{scrartcl}
   ```

5. **Verify visual markers in PDF:**

   - Line numbers on left margin (page 2+)
   - Citation style: (Author YYYY) vs [1]
   - ERSA logo in footer
   - Journal ISSN in footer

### Common Configuration Errors

#### Error 1: Wrong format identifier

```yaml
# WRONG - Too many path segments
format:
  region-ersa/REGION/pdf:
    ...

# WRONG - Missing namespace
format:
  REGION-pdf:
    ...

# CORRECT
format:
  region-ersa/REGION-pdf:
    keep-tex: true
    docstatus: review
    output-file: index-REGION
```

#### Error 2: Incompatible options

- Some extensions have strict option validation
- Start with minimal options, add incrementally
- Valid `docstatus` values for REGION: `review`, `final`, `uncorrected`

#### Error 3: Missing output-file specification

```yaml
# This generates BOTH PDFs but one might overwrite the other
format:
  region-ersa/REGION-pdf:
    # Missing: output-file: index-REGION
  pdf:
    # Missing: output-file: index
```

### Debugging Workflow

When template isn't applying:

1. **Enable keep-tex** in `_quarto.yml`:

   ```yaml
   region-ersa/REGION-pdf:
     keep-tex: true
   ```

2. **Clean and rebuild**:

   ```bash
   rm -f index*.pdf index*.tex
   rm -rf .quarto/
   quarto render index.qmd
   ```

3. **Inspect LaTeX source**:

   ```bash
   # Check for template markers
   grep -E "(documentclass|usepackage\{region\}|bibliographystyle)" index.tex
   ```

4. **Compare MD5 checksums** (but don't rely solely on this):

   ```bash
   md5 index.pdf index-REGION.pdf
   # Different checksums necessary but not sufficient
   ```

5. **Visual verification** (most reliable):

   - Open both PDFs side-by-side
   - Check for distinct visual markers
   - Confirm different citation styles

### Reference Documentation

For detailed troubleshooting of REGION template issues, see:
- [log/20260205_1245_fix_region_template.md](log/20260205_1245_fix_region_template.md) - Comprehensive troubleshooting guide
- [_extensions/region-ersa/REGION/_extension.yml](_extensions/region-ersa/REGION/_extension.yml) - Extension configuration
- [_quarto.yml](_quarto.yml) - Project format configuration

### Prevention Checklist

Before reporting template issues as "not working":

- [ ] Verified format identifier matches extension's `_extension.yml`
- [ ] Checked compilation logs for correct bibliography style
- [ ] Confirmed expected number of LaTeX passes (4 for REGION)
- [ ] Inspected LaTeX source with `keep-tex: true`
- [ ] Visually verified PDF has template markers (line numbers, branding)
- [ ] Compared both PDFs side-by-side for differences

---

## Workflow Guidelines

### Starting a New Session

1. Read this `CLAUDE.md` file
2. Check `./log/` for recent progress
3. Review project structure and goals
4. Understand what work has been completed

### During Work

1. Copy files from `./legacy/` when needed (never move)
2. Save intermediate results in appropriate directories
3. Document key decisions and findings
4. Create checkpoints for significant progress

### Ending a Session

1. Create a progress log in `./log/` with timestamp
2. Summarize work completed
3. Document next steps
4. Ensure all outputs are saved

---

**Remember:** These rules protect your work. When in doubt, copy rather than move, and log your progress.