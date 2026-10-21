# Run from the package root: source("scripts/build_site.R")
# Build pkgdown first, then render/copy Quarto presentations into docs/.
# External data analyses should be run separately and cached under results/.
if (!file.exists("DESCRIPTION") || !file.exists("_pkgdown.yml")) {
  stop("Run scripts/build_site.R from the package root.")
}
if (!requireNamespace("pkgdown", quietly = TRUE)) {
  stop("Install 'pkgdown' before building the site.")
}
if (Sys.which("quarto") == "") {
  stop("Install Quarto CLI before building presentations: https://quarto.org")
}

pkgdown::build_site()

slides <- list.files("presentations", pattern = "[.]qmd$", full.names = TRUE)
if (length(slides)) {
  dest <- file.path("docs", "presentations")
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  for (slide in slides) {
    # Quarto resolves the output dir relative to the source document.
    # Render to a local ignored folder, then copy to the pkgdown output.
    out_dir <- file.path("presentations", "_rendered")
    dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
    unlink(list.files(out_dir, full.names = TRUE, all.files = TRUE, no.. = TRUE), recursive = TRUE)
    cmd <- c("render", slide, "--output-dir", "_rendered")
    exit_code <- system2("quarto", cmd)
    if (!identical(exit_code, 0L)) stop("Quarto render failed: ", slide)
    created <- list.files(out_dir, all.files = TRUE, no.. = TRUE, full.names = TRUE)
    if (!length(created)) stop("No presentation output produced for ", slide)
    ok <- file.copy(created, dest, recursive = TRUE, overwrite = TRUE)
    if (!all(ok)) stop("Could not copy all rendered presentation files.")
    unlink(out_dir, recursive = TRUE)
  }
}
message("Website generated in docs/. Review before publishing.")
