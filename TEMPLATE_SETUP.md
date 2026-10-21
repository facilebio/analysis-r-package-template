# Set up a new analysis package

1. Create a GitHub repository from this repository via **Use this template**.
   Keep the new repo **private** if study context or reports are sensitive.
2. Clone the new repository and choose a valid R package name (ideally the
   same as the repository name).
3. From the repository root, run:

   ```bash
   Rscript scripts/initialize.R myAnalysis YOUR_GITHUB_OWNER
   ```

4. Edit `DESCRIPTION` (author, title, description, licensing), `README.md`,
   the study overview, analysis articles, and the presentation deck.
5. In R:

   ```r
   install.packages(c("devtools", "roxygen2", "pkgdown", "quarto"))
   devtools::document()
   devtools::test()
   source("scripts/build_site.R")
   ```

6. In repository **Settings > Pages**, select **GitHub Actions** as the build
   and deployment source. Push to `main` to publish. GitHub Pages access depends
   on repository visibility and your organization's plan/policies: treat Pages
   as **public** unless you explicitly verify access restrictions.
7. Add more reports under `vignettes/articles/` and list each in
   `_pkgdown.yml` under `articles:`. Add slide decks to `presentations/`
   and add links under `navbar.components.presentations.menu`.

## Architectural conventions

- `R/`: roxygen-documented reusable project functions.
- `vignettes/`: introductory analysis documentation.
- `vignettes/articles/`: website-only scientific reports, excluded from package.
- `presentations/`: independent Quarto RevealJS source; excluded from package.
- `data-raw/`: preparation scripts.
- `results/`: cached computational outputs; ignored by Git and package build.
- `docs/`: generated site; ignored by Git, deployed via Actions.

The GitHub workflow does **not** have access to local results data. Adapt it
if articles require cached RDS files, or publish pre-rendered reports after
review. Do not publish identifiable or proprietary experimental data.

## When to add usethis helpers

Use `usethis::use_test()`, `usethis::use_r()`, `usethis::use_dependency()`,
and `usethis::use_article()` while working on an instantiated project. There
is no need to maintain a separate scaffolding package initially.

## Known limitations

- This is a starter, not a tested R runtime build. `R` and Quarto CLI were
  unavailable in the creation environment. Validate with your local installation.
- `scripts/build_site.R` rebuilds slides each time. Render costs can be
  reduced with a content-hash cache or CI path filters later.
- Replace the basic GitHub Actions workflow if your company has stricter
  publishing/security policies.
