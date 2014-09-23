context("utilities")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

test_that("class is correct", {
    skip_unconnected()
    expect_that(generate_uuid(), is_a("ResourceId"))
})

test_that("result is list", {
    skip_unconnected()
    result <- get_transaction("E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")
    expect_that(result, is_a("list"))
})
