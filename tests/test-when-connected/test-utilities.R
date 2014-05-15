library(ripplerestr)
context("utilities")

test_that("class is correct", {
    expect_that(is(generate_uuid(), "ResourceId"), is_true())
})

test_that("result is list", {
    result <- get_transaction("E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")
    expect_that(result, is_a("list"))
})
