library(ripplerestr)
library(testthat)
context("inputs")

one <- "rrrrrrrrrrrrrrrrrrrrBZbvji"
two <- rep.int(one, 2)
cur <- c("USD", "EUR")
hash128 <- paste(rep.int("0", 32), collapse = "")
hash2 <- rep.int(hash128, 2)
hash256 <- paste(hash2, collapse = "")
hash4 <- rep.int(hash256, 2)
TF <- c(T, F)
amounts <- Amount(1:2, cur, two)
payments <- Payment(source_account = RippleAddress(two),
                    source_tag = UINT32(1:2),
                    source_amount = amounts,
                    source_slippage = 1:2,
                    destination_account = RippleAddress(two),
                    destination_tag = UINT32(1:2),
                    destination_amount = amounts,
                    invoice_id = Hash256(hash4),
                    paths = cur,
                    partial_payment = TF,
                    no_direct_ripple = TF)

test_that("wrong lengths throw errors", {
    expect_that(get_account_balances(two), throws_error("string"))
    expect_that(get_account_balances(one, cur), throws_error("string"))
    expect_that(get_account_balances(one,, two), throws_error("string"))
    expect_that(get_account_settings(two), throws_error("string"))
    expect_that(change_account_settings(two), throws_error("string"))
    expect_that(change_account_settings(one, two), throws_error("string"))
    expect_that(change_account_settings(one, one,
                                        transfer_rate = 1:2),
                throws_error("number"))
    expect_that(change_account_settings(one, one,
                                        domain = cur), throws_error("string"))
    expect_that(change_account_settings(one, one,
                                        message_key = cur),
                throws_error("string"))
    expect_that(change_account_settings(one, one,
                                        email_hash = hash2),
                throws_error("string"))
    expect_that(change_account_settings(one, one,
                                        disallow_xrp = TF),
                throws_error("flag"))
    expect_that(change_account_settings(one, one,
                                        require_authorization = TF),
                throws_error("flag"))
    expect_that(change_account_settings(one, one,
                                        require_destination_tag = TF),
                throws_error("flag"))
    expect_that(change_account_settings(one, one,
                                        password_spent = TF),
                throws_error("flag"))
    expect_that(get_notification(two), throws_error("string"))
    expect_that(get_notification(one, hash4), throws_error("string"))
    expect_that(get_payment_paths(two), throws_error("string"))
    expect_that(get_payment_paths(one, two), throws_error("string"))
    expect_that(get_payment_paths(one, one, amounts), throws_error("scalar"))
    expect_that(get_payment_paths(one, one,, 1:2), throws_error("number"))
    expect_that(get_payment_paths(one, one,, 1, cur), throws_error("string"))
    expect_that(get_payment_paths(one, one,, 1, "USD", two),
                throws_error("string"))
    expect_that(get_payment_paths(one, one, amounts[1],
                                  source_currencies = cur),
                throws_error("string"))
    expect_that(submit_payment(payments), throws_error("scalar"))
    expect_that(submit_payment(payments[1], two), throws_error("string"))
    expect_that(submit_payment(payments[1], one, cur), throws_error("string"))
    expect_that(check_payment_status(two), throws_error("string"))
    expect_that(check_payment_status(, two), throws_error("string"))
    expect_that(check_payment_status(, one, two), throws_error("string"))
    expect_that(check_payment_status(, one,, hash4), throws_error("string"))
    expect_that(get_account_payments(two), throws_error("string"))
    expect_that(get_account_payments(one, two), throws_error("string"))
    expect_that(get_account_payments(one,, two), throws_error("string"))
    expect_that(get_account_payments(one,,, TF), throws_error("flag"))
    expect_that(get_account_payments(one,,,, cur), throws_error("string"))
    expect_that(get_account_payments(one,,,,, TF), throws_error("flag"))
    expect_that(get_account_payments(one,,,,,, 1:2), throws_error("count"))
    expect_that(get_account_payments(one,,,,,,, 1:2), throws_error("count"))
    expect_that(get_account_payments(one,,,,,,,, 1:2), throws_error("count"))
    expect_that(get_account_payments(one,,,,,,,,, 1:2), throws_error("count"))
    expect_that(get_account_trustlines(two), throws_error("string"))
    expect_that(get_account_trustlines(one, cur), throws_error("string"))
    expect_that(get_account_trustlines(one,, two), throws_error("string"))
    expect_that(set_account_trustline(two), throws_error("string"))
    expect_that(set_account_trustline(one, two), throws_error("string"))
    expect_that(set_account_trustline(one, one, amounts),
                throws_error("scalar"))
    expect_that(set_account_trustline(one, one, amounts[1], TF),
                throws_error("flag"))
    expect_that(set_account_trustline(one, one,,, 1:2),
                throws_error("number"))
    expect_that(set_account_trustline(one, one,,, 1, "USD", two),
                throws_error("string"))
    expect_that(get_transaction(hash4), throws_error("string"))
})
