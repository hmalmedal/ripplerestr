library(ripplerestr)
library(testthat)
context("RippleAddress")

test_that("invalid addresses fail", {
    expect_that(RippleAddress("rrrrrrrrr"), throws_error())
})

test_that("class is correct", {
    root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
    expect_that(root_account, is_a("RippleAddress"))
})
