library(ripplerestr)
library(testthat)
context("UINT32")

test_that("negative integers fail", {
    expect_that(UINT32(-10:10), throws_error())
})

test_that("large integers fail", {
    expect_that(UINT32(2^32), throws_error())
})

test_that("non-integers fail", {
    expect_that(UINT32(1.5), throws_error())
})

test_that("class is correct", {
    x <- UINT32(c(0, 2^32-1))
    expect_that(x, is_a("UINT32"))
})
