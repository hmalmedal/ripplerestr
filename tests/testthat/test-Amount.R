context("Amount")

value  <- 0.001
currency <- Currency("USD")
issuer <- RippleAddress("rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B")
amount <- Amount(value = value,
                 currency = currency,
                 issuer = issuer)

test_that("classes are correct", {
    expect_that(amount, is_a("Amount"))
    expect_that(amount@value, is_a("numeric"))
    expect_that(amount@currency, is_a("Currency"))
    expect_that(amount@issuer, is_a("character"))
    expect_that(amount@counterparty, is_a("character"))
})

values <- seq(-1, 1, length.out = 26)
currencies <- Currency(paste0(LETTERS, rev(LETTERS), LETTERS))
root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")

amounts <- Amount(value = values, currency = currencies,
                  counterparty = rep.int(root_account, 26))

test_that("lengths are correct", {
    expect_that(length(amounts), equals(26))
    expect_that(length(amounts@value), equals(26))
    expect_that(length(amounts@currency), equals(26))
    expect_that(length(amounts@issuer), equals(26))
    expect_that(length(amounts@counterparty), equals(26))
})
