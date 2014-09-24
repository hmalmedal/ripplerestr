context("Amount")

value  <- 0.001
currency <- Currency("USD")
issuer <- RippleAddress("rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B")
amount <- Amount(value = value,
                 currency = currency,
                 issuer = issuer)

test_that("classes are correct", {
    expect_is(amount, "Amount")
    expect_is(amount@value, "numeric")
    expect_is(amount@currency, "Currency")
    expect_is(amount@issuer, "character")
    expect_is(amount@counterparty, "character")
})

values <- seq(-1, 1, length.out = 26)
currencies <- Currency(paste0(LETTERS, rev(LETTERS), LETTERS))
root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")

amounts <- Amount(value = values, currency = currencies,
                  counterparty = rep.int(root_account, 26))

test_that("lengths are correct", {
    expect_equal(length(amounts), 26)
    expect_equal(length(amounts@value), 26)
    expect_equal(length(amounts@currency), 26)
    expect_equal(length(amounts@issuer), 26)
    expect_equal(length(amounts@counterparty), 26)
})

test_that("addition results in numeric", {
    expect_is(amounts + amounts, "numeric")
    expect_is(amounts + 1, "numeric")
})

test_that("wrong length gives warning", {
    expect_warning(amounts - 1:3,
                   "longer object length is not a multiple of shorter object length")
})

test_that("f(amounts)@value = f(values)", {
    expect_equal(abs(amounts)@value, abs(values))
    expect_equal(asin(amounts)@value, asin(values))
})

test_that("summary values are correct", {
    expect_equal(max(amounts), max(values))
    expect_equal(min(amounts), min(values))
    expect_equal(range(amounts), range(values))
    expect_equal(prod(amounts), prod(values))
    expect_equal(sum(amounts), sum(values))
})

b <- as(amounts, "Balance")

test_that("different classes can be added", {
    expect_is(amounts + b, "numeric")
    expect_is(b + amounts, "numeric")
})
