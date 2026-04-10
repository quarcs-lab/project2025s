# Submission bundle — 2026-04-10

Journal submission artifacts for "Regional growth, convergence, and spatial spillovers in India: A reproducible view from outer space" by Mendez, Kabiraj, and Li. Target venue: REGION — The Journal of ERSA.

This directory is a snapshot of every file the journal submission system requires, frozen at the state of the `project2025s` repository on 2026-04-10. The files here are copies of outputs already present in the parent repository; nothing is moved, and nothing here depends on files outside this directory except where noted in the standalone HTML (see below).

## Contents

| File | Size | Purpose |
|---|---|---|
| `manuscript-REGION.pdf` | ~14 MB | Primary submission PDF, typeset with the REGION journal template (A4, author-year citations, line numbers). Identical to `index-REGION.pdf` at the repository root. |
| `manuscript.docx` | ~11 MB | Microsoft Word version of the manuscript, for editors who need a Word file. Identical to `index.docx` at the repository root. |
| `manuscript-standalone.html` | ~20 MB | Single-file HTML version of the paper. All figures, math, CSS, and MathJax are base64-embedded. Open it in any modern browser — no internet connection needed. Notebook cross-links resolve to the live GitHub repository. |
| `latex-manuscript/` | — | Self-contained LaTeX source tree. A reviewer can recompile the REGION PDF using only the files in this subdirectory. See `latex-manuscript/README.md` for compile instructions. |

## How each artifact was produced

**`manuscript-REGION.pdf` and `manuscript.docx`** come from the standard project render: `bash scripts/clean-render.sh` at the repository root, which runs Quarto against `index.qmd` and generates all output formats. These files are exact copies, not re-renders, so they match the live site.

**`manuscript-standalone.html`** was produced with a one-off Quarto command that overrides the `embed-resources` flag without modifying `_quarto.yml`:

```
quarto render index.qmd --to html -M embed-resources:true --output manuscript-standalone.html
```

This command builds a single-file HTML where every asset (CSS, JS, fonts, MathJax, figures) is inlined as base64, without clobbering the normal multi-file `index.html` that powers the GitHub Pages site. To regenerate this file, re-run the same command and move the result into this directory.

**`latex-manuscript/`** is a hand-assembled tree containing `manuscript.tex` (a copy of the Quarto-rendered `index-REGION.tex` with figure paths flattened to `figures/`), `references.bib`, the REGION template class and style files (`regart.cls`, `region.sty`, `region.bst`, title-page assets), and a `figures/` subdirectory holding every image referenced by the manuscript body. The reviewer compiles it with `lualatex` + `bibtex`; see the subdirectory's own README for the exact sequence.

## What is NOT in this directory (and where to find it)

- **Computational notebooks.** The analysis notebooks (`notebooks/c01_view_from_space.ipynb`, `c02_regional_convergence_sc.ipynb`, `c03_spatial_dependence_lisa.ipynb`, `c04_spillover_modeling_6nn.ipynb`, `c06_spatial_culture.ipynb`) are not duplicated here because they are large and because the single-file HTML already embeds their rendered outputs. Reviewers who want the executable notebooks should go to the repository: <https://github.com/quarcs-lab/project2025s/tree/master/notebooks>
- **Data files.** Raw nighttime lights data and shapefiles are hosted with the notebooks in the live repository. See the repository README for data download instructions.
- **Supporting scripts and Quarto configuration.** The `scripts/`, `_extensions/`, and `_quarto.yml` files that power the Quarto build are not copied here; only the outputs they produce are.

## Verification record

Before this bundle was committed, the standalone LaTeX tree was compiled from scratch to confirm that `manuscript.tex` builds correctly using only the files in `latex-manuscript/`. The resulting PDF was page-compared against `manuscript-REGION.pdf` for parity. Any mismatch would have blocked the commit.

## Provenance

Generated from commit `aa159dc` of the `project2025s` repository on 2026-04-10. That commit is the first one containing the corrected `references.bib` metadata for the Adhikari & Dhital, Jha & Talathi, Chanda & Cook, Chakravarty & Dehejia, and Li et al. entries. See the commit message and `log/` directory for the full correction history.
