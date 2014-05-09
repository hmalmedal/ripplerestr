library(ripplerestr)
context("notifications")

nf <- get_notification("r3PDtZSa5LiYp1Ysn1vMuMzB59RzV3W9QH",
                       "E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")

test_that("classes are correct", {
    expect_that(is(nf, "Notification"), is_true())
    expect_that(is(nf@account, "RippleAddress"), is_true())
    expect_that(is(nf@type, "character"), is_true())
    expect_that(is(nf@direction, "character"), is_true())
    expect_that(is(nf@state, "character"), is_true())
    expect_that(is(nf@result, "character"), is_true())
    expect_that(is(nf@ledger, "numeric"), is_true())
    expect_that(is(nf@hash, "Hash256"), is_true())
    expect_that(is(nf@timestamp, "POSIXct"), is_true())
    expect_that(is(nf@transaction_url, "character"), is_true())
    expect_that(is(nf@previous_notification_url, "character"), is_true())
    expect_that(is(nf@next_notification_url, "character"), is_true())
})
