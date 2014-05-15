context("Currency")

test_that("invalid currencies fail", {
    expect_that(Currency("dollar"), throws_error())
    expect_that(Currency(" USD"), throws_error())
})

test_that("class is correct", {
    USD <- Currency("USD")
    expect_that(USD, is_a("Currency"))
    XAU <- Currency("015841551A748AD2C1F76FF6ECB0CCCD00000000")
    expect_that(XAU, is_a("Currency"))
})
