context("inputs")

one <- "rrrrrrrrrrrrrrrrrrrrBZbvji"
two <- rep.int(one, 2)
cur <- c("USD", "EUR")
hash128 <- paste(rep.int("0", 32), collapse = "")
hash2 <- rep.int(hash128, 2)
hash256 <- paste(hash2, collapse = "")
hash4 <- rep.int(hash256, 2)
TF <- c(TRUE, FALSE)
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
    expect_error(get_account_balances(two), "string")
    expect_error(get_account_balances(one, cur), "string")
    expect_error(get_account_balances(one,, two), "string")
    expect_error(get_account_settings(two), "string")
    expect_error(change_account_settings(two), "string")
    expect_error(change_account_settings(one, two), "string")
    expect_error(change_account_settings(one, one, transfer_rate = 1:2),
                 "number")
    expect_error(change_account_settings(one, one, domain = cur), "string")
    expect_error(change_account_settings(one, one, message_key = cur), "string")
    expect_error(change_account_settings(one, one, email_hash = hash2),
                 "string")
    expect_error(change_account_settings(one, one, disallow_xrp = TF), "flag")
    expect_error(change_account_settings(one, one, require_authorization = TF),
                 "flag")
    expect_error(change_account_settings(one, one,
                                         require_destination_tag = TF), "flag")
    expect_error(change_account_settings(one, one, password_spent = TF), "flag")
    expect_error(get_notification(two), "string")
    expect_error(get_notification(one, hash4), "string")
    expect_error(get_payment_paths(two), "string")
    expect_error(get_payment_paths(one, two), "string")
    expect_error(get_payment_paths(one, one, amounts), "scalar")
    expect_error(get_payment_paths(one, one,, 1:2), "number")
    expect_error(get_payment_paths(one, one,, 1, cur), "string")
    expect_error(get_payment_paths(one, one,, 1, "USD", two), "string")
    expect_error(get_payment_paths(one, one, amounts[1],
                                   source_currencies = cur), "string")
    expect_error(submit_payment(payments), "scalar")
    expect_error(submit_payment(payments[1], two), "string")
    expect_error(submit_payment(payments[1], one, cur), "string")
    expect_error(check_payment_status(two), "string")
    expect_error(check_payment_status(, two), "string")
    expect_error(check_payment_status(, one, two), "string")
    expect_error(check_payment_status(, one,, hash4), "string")
    expect_error(get_account_payments(two), "string")
    expect_error(get_account_payments(one, two), "string")
    expect_error(get_account_payments(one,, two), "string")
    expect_error(get_account_payments(one,,, TF), "flag")
    expect_error(get_account_payments(one,,,, cur), "string")
    expect_error(get_account_payments(one,,,,, TF), "flag")
    expect_error(get_account_payments(one,,,,,, 1:2), "count")
    expect_error(get_account_payments(one,,,,,,, 1:2), "count")
    expect_error(get_account_payments(one,,,,,,,, 1:2), "count")
    expect_error(get_account_payments(one,,,,,,,,, 1:2), "count")
    expect_error(get_account_trustlines(two), "string")
    expect_error(get_account_trustlines(one, cur), "string")
    expect_error(get_account_trustlines(one,, two), "string")
    expect_error(set_account_trustline(two), "string")
    expect_error(set_account_trustline(one, two), "string")
    expect_error(set_account_trustline(one, one, amounts), "scalar")
    expect_error(set_account_trustline(one, one, amounts[1], TF), "flag")
    expect_error(set_account_trustline(one, one,,, 1:2), "number")
    expect_error(set_account_trustline(one, one,,, 1, "USD", two), "string")
    expect_error(get_transaction(hash4), "string")
})
