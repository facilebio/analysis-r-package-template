#' Return a compact project status summary
#'
#' A minimal exported function to illustrate project-level helpers.
#'
#' @param n_samples Number of samples in the experiment.
#' @return A one-row data frame.
#' @export
project_summary <- function(n_samples) {
  stopifnot(length(n_samples) == 1L, is.numeric(n_samples),
            is.finite(n_samples), n_samples >= 0)
  data.frame(samples = n_samples)
}
