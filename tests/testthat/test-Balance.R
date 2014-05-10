context("Balance")

values <- seq(-1, 1, length.out = 26)
currencies <- Currency(paste0(LETTERS, rev(LETTERS), LETTERS))
root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")

b <- Balance(value = values, currency = currencies,
             counterparty = rep.int(root_account, 26))

test_that("addition results in numeric", {
    expect_that(is(b + b, "numeric"), is_true())
    expect_that(is(b + 1, "numeric"), is_true())
})

test_that("wrong length gives warning", {
    expect_that(b - 1:3, gives_warning())
})

test_that("f(b)@value = f(values)", {
    expect_that(abs(b)@value, equals(abs(values)))
    expect_that(asin(b)@value, equals(asin(values)))
})

test_that("summary values are correct", {
    expect_that(max(b), equals(max(values)))
    expect_that(min(b), equals(min(values)))
    expect_that(range(b), equals(range(values)))
    expect_that(prod(b), equals(prod(values)))
    expect_that(sum(b), equals(sum(values)))
})