context("Balance")

values <- seq(-1, 1, length.out = 26)
currencies <- Currency(paste0(LETTERS, rev(LETTERS), LETTERS))
root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")

b <- Balance(value = values, currency = currencies,
             counterparty = rep.int(root_account, 26))

test_that("addition results in numeric", {
    expect_is(b + b, "numeric")
    expect_is(b + 1, "numeric")
})

test_that("wrong length gives warning", {
    expect_warning(b - 1:3,
                   "longer object length is not a multiple of shorter object length")
})

test_that("f(b)@value = f(values)", {
    expect_equal(abs(b)@value, abs(values))
    expect_equal(asin(b)@value, asin(values))
})

test_that("summary values are correct", {
    expect_equal(max(b), max(values))
    expect_equal(min(b), min(values))
    expect_equal(range(b), range(values))
    expect_equal(prod(b), prod(values))
    expect_equal(sum(b), sum(values))
})

amounts <- as(b, "Amount")

test_that("different classes can be added", {
    expect_is(amounts + b, "numeric")
    expect_is(b + amounts, "numeric")
})
