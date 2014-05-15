library(ripplerestr)
context("notifications")

test_that("classes are correct", {
    nf <- get_notification("r3PDtZSa5LiYp1Ysn1vMuMzB59RzV3W9QH",
                           "E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")
    expect_that(nf, is_a("Notification"))
    expect_that(nf@account, is_a("RippleAddress"))
    expect_that(nf@type, is_a("character"))
    expect_that(nf@direction, is_a("character"))
    expect_that(nf@state, is_a("character"))
    expect_that(nf@result, is_a("character"))
    expect_that(nf@ledger, is_a("numeric"))
    expect_that(nf@hash, is_a("Hash256"))
    expect_that(nf@timestamp, is_a("POSIXct"))
    expect_that(nf@transaction_url, is_a("character"))
    expect_that(nf@previous_notification_url, is_a("character"))
    expect_that(nf@next_notification_url, is_a("character"))
})
