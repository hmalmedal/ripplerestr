context("server")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

test_that("result is boolean", {
    expect_that(is_server_connected(), is_a("logical"))
})

test_that("result is list", {
    skip_unconnected()
    result <- get_server_status()
    expect_that(result, is_a("list"))
    expect_that(result$rippled_server_status, is_a("list"))
    expect_that(result$rippled_server_status$last_close, is_a("list"))
    expect_that(result$rippled_server_status$validated_ledger, is_a("list"))
})
