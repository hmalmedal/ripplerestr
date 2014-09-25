context("accounts")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

test_that("get_account_balances", {
    skip_unconnected()

    root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
    result <- get_account_balances(root_account)

    expect_is(result, "Balance")
    expect_is(result@value, "numeric")
    expect_is(result@currency, "Currency")
    expect_is(result@counterparty, "character")
    expect_equal(result[1]@currency, Currency("XRP"))
    expect_equal(result[1]@counterparty, "")

    n <- length(result)

    expect_equal(n, length(result@value))
    expect_equal(n, length(result@currency))
    expect_equal(n, length(result@counterparty))
})

test_that("get_account_settings", {
    skip_unconnected()

    black_hole <- RippleAddress("rJp2sUmi2iTbWzqhxoYnNAg4QqCxgByCTy")
    result <- get_account_settings(black_hole)

    expect_is(result, "AccountSettings")
    expect_is(result@account, "RippleAddress")
    expect_is(result@regular_key, "RippleAddress")
    expect_is(result@domain, "character")
    expect_is(result@email_hash, "Hash128")
    expect_is(result@message_key, "character")
    expect_is(result@transfer_rate, "UINT32")
    expect_is(result@require_destination_tag, "logical")
    expect_is(result@require_authorization, "logical")
    expect_is(result@disallow_xrp, "logical")
    expect_is(result@password_spent, "logical")
    expect_is(result@disable_master, "logical")
    expect_is(result@transaction_sequence, "UINT32")
    expect_is(result@trustline_count, "UINT32")
    expect_is(result@ledger, "numeric")
    expect_is(result@hash, "Hash256")
    expect_equal(result@account, black_hole)
    expect_equal(result@transfer_rate, UINT32(0))
    expect_false(result@require_destination_tag)
    expect_false(result@require_authorization)
    expect_false(result@disallow_xrp)
    expect_true(result@password_spent)
    expect_true(result@disable_master)
    expect_equal(result@transaction_sequence, UINT32(14))
})

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"

test_that("transfer rate less than 1 gives error", {
    expect_error(change_account_settings(address = address,
                                         secret = secret,
                                         transfer_rate = 0.9),
                 "not greater than or equal to")
})

test_that("no provided settings gives error", {
    expect_error(change_account_settings(address = address,
                                         secret = secret),
                 "No settings provided")
})

transfer_rate = 18/17
domain <- "example.com"
email_hash <- "B58996C504C5638798EB6B511E6F49AF"

test_that("account settings are correct", {
    skip_unconnected()

    result <- change_account_settings(address = address,
                                      secret = secret,
                                      transfer_rate = transfer_rate,
                                      domain = domain,
                                      email_hash = email_hash,
                                      disallow_xrp = TRUE,
                                      require_authorization = FALSE,
                                      require_destination_tag = TRUE)

    expect_is(result, "AccountSettings")
    expect_is(result@account, "RippleAddress")
    expect_is(result@regular_key, "RippleAddress")
    expect_is(result@domain, "character")
    expect_is(result@email_hash, "Hash128")
    expect_is(result@message_key, "character")
    expect_is(result@transfer_rate, "UINT32")
    expect_is(result@require_destination_tag, "logical")
    expect_is(result@require_authorization, "logical")
    expect_is(result@disallow_xrp, "logical")
    expect_is(result@password_spent, "logical")
    expect_is(result@disable_master, "logical")
    expect_is(result@transaction_sequence, "UINT32")
    expect_is(result@trustline_count, "UINT32")
    expect_is(result@ledger, "numeric")
    expect_is(result@hash, "Hash256")

    expect_equal(result@account, address)
    expect_equal(result@transfer_rate, UINT32(round(transfer_rate * 1e9)))
    expect_equal(result@domain, domain)
    expect_equal(result@email_hash, Hash128(email_hash))

    expect_true(result@disallow_xrp)
    expect_false(result@require_authorization)
    expect_true(result@require_destination_tag)
})

test_that("generate_account", {
    skip_unconnected()

    result <- generate_account()

    expect_is(result, "list")
    expect_equal(length(result), 2)
})
