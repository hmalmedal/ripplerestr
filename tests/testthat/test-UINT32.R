context("UINT32")

test_that("negative integers fail", {
    expect_error(UINT32(-10:10), "not true")
})

test_that("large integers fail", {
    expect_error(UINT32(2^32), "not true")
})

test_that("non-integers fail", {
    expect_error(UINT32(1.5), "not true")
})

test_that("class is correct", {
    x <- UINT32(c(0, 2^32-1))
    expect_is(x, "UINT32")
})
