context("notifications")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

test_that("notifications are correct", {
    skip_unconnected()

    nf <- get_notification("r3PDtZSa5LiYp1Ysn1vMuMzB59RzV3W9QH",
                           "E08D6E9754025BA2534A78707605E0601F03ACE063687A0CA1BDDACFCD1698C7")

    expect_is(nf, "Notification")
    expect_is(nf@account, "RippleAddress")
    expect_is(nf@type, "character")
    expect_is(nf@direction, "character")
    expect_is(nf@state, "character")
    expect_is(nf@result, "character")
    expect_is(nf@ledger, "numeric")
    expect_is(nf@hash, "Hash256")
    expect_is(nf@timestamp, "POSIXct")
    expect_is(nf@transaction_url, "character")
    expect_is(notification_url(nf, TRUE), "character")
    expect_is(notification_url(nf, FALSE), "character")
})
