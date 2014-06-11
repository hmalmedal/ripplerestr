library(ripplerestr)
library(testthat)
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

test_that("addition results in numeric", {
    expect_that(amounts + amounts, is_a("numeric"))
    expect_that(amounts + 1, is_a("numeric"))
})

test_that("wrong length gives warning", {
    expect_that(amounts - 1:3, gives_warning())
})

test_that("f(amounts)@value = f(values)", {
    expect_that(abs(amounts)@value, equals(abs(values)))
    expect_that(asin(amounts)@value, equals(asin(values)))
})

test_that("summary values are correct", {
    expect_that(max(amounts), equals(max(values)))
    expect_that(min(amounts), equals(min(values)))
    expect_that(range(amounts), equals(range(values)))
    expect_that(prod(amounts), equals(prod(values)))
    expect_that(sum(amounts), equals(sum(values)))
})

b <- as(amounts, "Balance")

test_that("different classes can be added", {
    expect_that(amounts + b, is_a("numeric"))
    expect_that(b + amounts, is_a("numeric"))
})
