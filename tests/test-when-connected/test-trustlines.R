library(ripplerestr)
context("trustlines")

root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
result <- get_account_trustlines(root_account)

test_that("classes are correct", {
    expect_that(result, is_a("Trustline"))
    expect_that(result@account, is_a("RippleAddress"))
    expect_that(result@counterparty, is_a("RippleAddress"))
    expect_that(result@currency, is_a("Currency"))
    expect_that(result@limit, is_a("numeric"))
    expect_that(result@reciprocated_limit, is_a("numeric"))
    expect_that(result@account_allows_rippling, is_a("logical"))
    expect_that(result@counterparty_allows_rippling, is_a("logical"))
    expect_that(result@ledger, is_a("numeric"))
    expect_that(result@hash, is_a("Hash256"))
})

test_that("slot lengths are equal to object length", {
    n <- length(result)
    expect_that(n, equals(length(result@account)))
    expect_that(n, equals(length(result@counterparty)))
    expect_that(n, equals(length(result@currency)))
    expect_that(n, equals(length(result@limit)))
    expect_that(n, equals(length(result@reciprocated_limit)))
    expect_that(n, equals(length(result@account_allows_rippling)))
    expect_that(n, equals(length(result@counterparty_allows_rippling)))
    expect_that(n, equals(length(result@ledger)))
    expect_that(n, equals(length(result@hash)))
})

address <- "rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd"
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"
limit <- 1000
currency <- Currency("USD")
counterparty <- root_account
amount <- Amount(value = limit,
                 currency = currency,
                 counterparty = counterparty)
result <- set_account_trustline(address, secret, amount)

test_that("classes are correct", {
    expect_that(result, is_a("Trustline"))
    expect_that(result@account, is_a("RippleAddress"))
    expect_that(result@counterparty, is_a("RippleAddress"))
    expect_that(result@currency, is_a("Currency"))
    expect_that(result@limit, is_a("numeric"))
    expect_that(result@reciprocated_limit, is_a("numeric"))
    expect_that(result@account_allows_rippling, is_a("logical"))
    expect_that(result@counterparty_allows_rippling, is_a("logical"))
    expect_that(result@ledger, is_a("numeric"))
    expect_that(result@hash, is_a("Hash256"))
})

test_that("object length and slot lengths are 1", {
    n <- 1
    expect_that(n, equals(length(result)))
    expect_that(n, equals(length(result@account)))
    expect_that(n, equals(length(result@counterparty)))
    expect_that(n, equals(length(result@currency)))
    expect_that(n, equals(length(result@limit)))
    expect_that(n, equals(length(result@reciprocated_limit)))
    expect_that(n, equals(length(result@account_allows_rippling)))
    expect_that(n, equals(length(result@counterparty_allows_rippling)))
    expect_that(n, equals(length(result@ledger)))
    expect_that(n, equals(length(result@hash)))
})
