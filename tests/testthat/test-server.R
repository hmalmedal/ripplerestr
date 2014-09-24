context("server")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

test_that("result is boolean", {
    expect_is(is_server_connected(), "logical")
})

test_that("result is list", {
    skip_unconnected()

    result <- get_server_status()

    expect_is(result, "list")
    expect_is(result$rippled_server_status, "list")
    expect_is(result$rippled_server_status$last_close, "list")
    expect_is(result$rippled_server_status$validated_ledger, "list")
})
