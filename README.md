# Analysis project

A reproducible analysis project organized as an R package. The **website**
provides analyses and presentations; the **package** holds reusable functions.

## Study overview

Replace this paragraph with the biological question, model system, data sources,
experimental design, and top-level conclusions.

## Analyses

See the **Analyses** navigation tab for individual reports.

## Presentations

See the **Presentations** tab for slide decks. Slides are built independently
from Quarto article/vignette rendering.

## Reproducibility

Large data and analysis outputs live in `results/` and are not installed with
the package or published by default. Only publish non-sensitive aggregated outputs.

## Development

```r
install.packages(c("devtools", "pkgdown", "quarto", "roxygen2"))
devtools::document()
source("scripts/build_site.R")
```

Quarto CLI must also be installed: https://quarto.org/docs/get-started/
