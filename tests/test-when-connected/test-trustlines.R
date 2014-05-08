library(ripplerestr)
context("trustlines")

root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
result <- get_account_trustlines(root_account)

test_that("class is correct", {
    expect_that(is(result, "Trustline"), is_true())
    expect_that(is(result@account, "RippleAddress"), is_true())
    expect_that(is(result@counterparty, "RippleAddress"), is_true())
    expect_that(is(result@currency, "Currency"), is_true())
    expect_that(is(result@hash, "Hash256"), is_true())
})
