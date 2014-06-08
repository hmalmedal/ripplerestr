library(ripplerestr)
library(testthat)
context("notifications")

nf <- get_notification("r3PDtZSa5LiYp1Ysn1vMuMzB59RzV3W9QH",
                       "E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")

test_that("classes are correct", {
    expect_that(nf, is_a("Notification"))
    expect_that(nf@account, is_a("RippleAddress"))
    expect_that(nf@type, is_a("character"))
    expect_that(nf@direction, is_a("character"))
    expect_that(nf@state, is_a("character"))
    expect_that(nf@result, is_a("character"))
    expect_that(nf@ledger, is_a("numeric"))
    expect_that(nf@hash, is_a("Hash256"))
    expect_that(nf@timestamp, is_a("POSIXct"))
    expect_that(nf@timestamp, not(equals(as.POSIXct(NA))))
    expect_that(nf@transaction_url, is_a("character"))
    expect_that(notification_url(nf, T), is_a("character"))
    expect_that(notification_url(nf, F), is_a("character"))
})

test_that("directions are correct", {
    expect_that(notification_url(nf), equals(notification_url(nf, F)))
    expect_that(notification_url(nf, T), not(equals(notification_url(nf, F))))
})
