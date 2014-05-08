library(ripplerestr)
context("server")

test_that("result is boolean", {
    expect_that(is(is_server_connected(), "logical"), is_true())
})

test_that("result is list", {
    result <- get_server_status()
    expect_that(is(result, "list"), is_true())
    expect_that(is(result$rippled_server_status, "list"), is_true())
    expect_that(is(result$rippled_server_status$last_close, "list"), is_true())
    expect_that(is(result$rippled_server_status$validated_ledger, "list"),
                is_true())
})
