context("trustlines")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")

test_that("get_account_trustlines", {
    skip_unconnected()

    result <- get_account_trustlines(root_account)

    expect_is(result, "Trustline")
    expect_is(result@account, "RippleAddress")
    expect_is(result@counterparty, "RippleAddress")
    expect_is(result@currency, "Currency")
    expect_is(result@limit, "numeric")
    expect_is(result@reciprocated_limit, "numeric")
    expect_is(result@account_allows_rippling, "logical")
    expect_is(result@counterparty_allows_rippling, "logical")
    expect_is(result@ledger, "numeric")
    expect_is(result@hash, "Hash256")

    n <- length(result)

    expect_equal(n, length(result@account))
    expect_equal(n, length(result@counterparty))
    expect_equal(n, length(result@currency))
    expect_equal(n, length(result@limit))
    expect_equal(n, length(result@reciprocated_limit))
    expect_equal(n, length(result@account_allows_rippling))
    expect_equal(n, length(result@counterparty_allows_rippling))
    expect_equal(n, length(result@ledger))
    expect_equal(n, length(result@hash))
})

address <- "rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd"
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"
limit <- 1000
currency <- Currency("USD")
counterparty <- root_account
amount <- Amount(value = limit,
                 currency = currency,
                 counterparty = counterparty)

test_that("set_account_trustline", {
    skip_unconnected()

    result <- set_account_trustline(address, secret, amount)

    expect_is(result, "Trustline")
    expect_is(result@account, "RippleAddress")
    expect_is(result@counterparty, "RippleAddress")
    expect_is(result@currency, "Currency")
    expect_is(result@limit, "numeric")
    expect_is(result@reciprocated_limit, "numeric")
    expect_is(result@account_allows_rippling, "logical")
    expect_is(result@counterparty_allows_rippling, "logical")
    expect_is(result@ledger, "numeric")
    expect_is(result@hash, "Hash256")

    n <- 1

    expect_equal(n, length(result))
    expect_equal(n, length(result@account))
    expect_equal(n, length(result@counterparty))
    expect_equal(n, length(result@currency))
    expect_equal(n, length(result@limit))
    expect_equal(n, length(result@reciprocated_limit))
    expect_equal(n, length(result@account_allows_rippling))
    expect_equal(n, length(result@counterparty_allows_rippling))
    expect_equal(n, length(result@ledger))
    expect_equal(n, length(result@hash))
})
