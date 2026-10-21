test_that("project_summary reports sample count", {
  expect_equal(project_summary(5)$samples, 5)
})
