library(ripplerestr)
context("accounts")

root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
result <- get_account_balances(root_account)

test_that("class is correct", {
    expect_that(is(result, "Balance"), is_true())
    expect_that(is(result@value, "numeric"), is_true())
    expect_that(is(result@currency, "Currency"), is_true())
    expect_that(is(result@counterparty, "character"), is_true())
})

test_that("first result is XRP", {
    expect_that(result[1]@currency, equals(Currency("XRP")))
    expect_that(result[1]@counterparty, equals(""))
})

test_that("slot lengths are equal to object length", {
    n <- length(result)
    expect_that(n, equals(length(result@value)))
    expect_that(n, equals(length(result@currency)))
    expect_that(n, equals(length(result@counterparty)))
})
