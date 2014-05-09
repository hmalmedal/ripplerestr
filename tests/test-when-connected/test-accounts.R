library(ripplerestr)
context("accounts")

root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
result <- get_account_balances(root_account)

test_that("classes are correct", {
    expect_that(is(result, "Balance"), is_true())
    expect_that(is(result@value, "numeric"), is_true())
    expect_that(is(result@currency, "Currency"), is_true())
    expect_that(is(result@counterparty, "character"), is_true())
})

test_that("first result is XRP", {
    expect_that(result[1]@currency, equals(Currency("XRP")))
    expect_that(result[1]@counterparty, equals(""))
})

test_that("slot lengths are equal to object length", {
    n <- length(result)
    expect_that(n, equals(length(result@value)))
    expect_that(n, equals(length(result@currency)))
    expect_that(n, equals(length(result@counterparty)))
})

black_hole <- RippleAddress("rJp2sUmi2iTbWzqhxoYnNAg4QqCxgByCTy")
result <- get_account_settings(black_hole)

test_that("classes are correct", {
    expect_that(is(result, "AccountSettings"), is_true())
    expect_that(is(result@account, "RippleAddress"), is_true())
    expect_that(is(result@regular_key, "RippleAddress"), is_true())
    expect_that(is(result@domain, "character"), is_true())
    expect_that(is(result@email_hash, "Hash128"), is_true())
    expect_that(is(result@message_key, "character"), is_true())
    expect_that(is(result@transfer_rate, "UINT32"), is_true())
    expect_that(is(result@require_destination_tag, "logical"), is_true())
    expect_that(is(result@require_authorization, "logical"), is_true())
    expect_that(is(result@disallow_xrp, "logical"), is_true())
    expect_that(is(result@password_spent, "logical"), is_true())
    expect_that(is(result@disable_master, "logical"), is_true())
    expect_that(is(result@transaction_sequence, "UINT32"), is_true())
    expect_that(is(result@trustline_count, "UINT32"), is_true())
    expect_that(is(result@ledger, "numeric"), is_true())
    expect_that(is(result@hash, "Hash256"), is_true())
})

test_that("slot values are correct", {
    expect_that(result@account, equals(black_hole))
    expect_that(result@transfer_rate, equals(UINT32(0)))
    expect_that(result@require_destination_tag, equals(F))
    expect_that(result@require_authorization, equals(F))
    expect_that(result@disallow_xrp, equals(F))
    expect_that(result@password_spent, equals(T))
    expect_that(result@disable_master, equals(T))
    expect_that(result@transaction_sequence, equals(UINT32(14)))
})
