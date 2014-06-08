library(ripplerestr)
library(testthat)
context("Hash256")

test_that("invalid hashes fail", {
    expect_that(Hash256("E08D6E97"), throws_error())
})

test_that("class is correct", {
    hash <- Hash256("E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")
    expect_that(hash, is_a("Hash256"))
})
