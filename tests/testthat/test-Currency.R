context("Currency")

test_that("invalid currencies fail", {
    expect_error(Currency("dollar"), "currency")
    expect_error(Currency(" USD"), "currency")
})

test_that("class is correct", {
    USD <- Currency("USD")
    expect_is(USD, "Currency")
    XAU <- Currency("015841551A748AD2C1F76FF6ECB0CCCD00000000")
    expect_is(XAU, "Currency")
})
