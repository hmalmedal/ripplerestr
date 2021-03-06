context("ResourceId")

test_that("256-bit hex strings fail", {
    expect_error(ResourceId("E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7"),
                 "resource ID")
})

test_that("class is correct", {
    id <- ResourceId("5ee51660-df56-4355-a086-277a4b8ad538")
    expect_is(id, "ResourceId")
})
