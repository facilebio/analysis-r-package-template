# Run from repository root, once after creating a repository from the template:
# Rscript scripts/initialize.R YOUR_PACKAGE_NAME YOUR_GITHUB_OWNER
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2L) {
  stop("Usage: Rscript scripts/initialize.R <valid_package_name> <github_owner>")
}
package <- args[[1]]
owner <- args[[2]]
if (!grepl("^[A-Za-z][A-Za-z0-9.]*$", package) || grepl("\.$", package)) {
  stop("Package name must start with a letter and contain only letters, numbers, periods.")
}
if (!grepl("^[A-Za-z0-9-]+$", owner)) stop("Invalid GitHub owner")
if (!file.exists("DESCRIPTION")) stop("Run from the repository root.")
if (read.dcf("DESCRIPTION", fields = "Package")[[1]] != "analysisproject") {
  stop("Template already initialized (or DESCRIPTION was customized).")
}
replace_in <- function(path, before, after) {
  x <- readLines(path, warn = FALSE)
  x <- gsub(before, after, x, fixed = TRUE)
  writeLines(x, path)
}
replace_in("DESCRIPTION", "Package: analysisproject", paste0("Package: ", package))
replace_in("tests/testthat.R", "analysisproject", package)
# Set an explicit public site address only if the repository name equals the package name.
url <- sprintf("https://%s.github.io/%s/", owner, package)
cat("\nurl: ", url, "\n", file = "_pkgdown.yml", append = TRUE, sep = "")
cat("\nURL: ", url, "\n", file = "DESCRIPTION", append = TRUE, sep = "")
message("Initialized package: ", package, " ; expected site: ", url)
message("Update author details and title in DESCRIPTION, and LICENSE files.")
message("If the repository name differs from the package name, edit the URL manually.")
message("Run devtools::document() before R CMD check or installation.")
