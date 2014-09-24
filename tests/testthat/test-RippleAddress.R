context("RippleAddress")

test_that("invalid addresses fail", {
    expect_error(RippleAddress("rrrrrrrrr"), "address")
})

test_that("class is correct", {
    root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
    expect_is(root_account, "RippleAddress")
})
