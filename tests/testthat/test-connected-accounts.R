library(ripplerestr)
library(testthat)
context("accounts")

root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
result <- get_account_balances(root_account)

test_that("classes are correct", {
    expect_that(result, is_a("Balance"))
    expect_that(result@value, is_a("numeric"))
    expect_that(result@currency, is_a("Currency"))
    expect_that(result@counterparty, is_a("character"))
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

test_that("query parameters don't give errors", {
    expect_that(get_account_balances(root_account,
                                     currency = "USD",
                                     counterparty =
                                         "rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd"),
                not(throws_error()))
    expect_that(get_account_balances(root_account,
                                     currency = "USD"),
                not(throws_error()))
    expect_that(get_account_balances(root_account,
                                     counterparty =
                                         "rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd"),
                not(throws_error()))
})

black_hole <- RippleAddress("rJp2sUmi2iTbWzqhxoYnNAg4QqCxgByCTy")
result <- get_account_settings(black_hole)

test_that("classes are correct", {
    expect_that(result, is_a("AccountSettings"))
    expect_that(result@account, is_a("RippleAddress"))
    expect_that(result@regular_key, is_a("RippleAddress"))
    expect_that(result@domain, is_a("character"))
    expect_that(result@email_hash, is_a("Hash128"))
    expect_that(result@message_key, is_a("character"))
    expect_that(result@transfer_rate, is_a("UINT32"))
    expect_that(result@require_destination_tag, is_a("logical"))
    expect_that(result@require_authorization, is_a("logical"))
    expect_that(result@disallow_xrp, is_a("logical"))
    expect_that(result@password_spent, is_a("logical"))
    expect_that(result@disable_master, is_a("logical"))
    expect_that(result@transaction_sequence, is_a("UINT32"))
    expect_that(result@trustline_count, is_a("UINT32"))
    expect_that(result@ledger, is_a("numeric"))
    expect_that(result@hash, is_a("Hash256"))
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

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"

test_that("transfer rate less than 1 gives error", {
    expect_that(change_account_settings(address = address,
                                        secret = secret,
                                        transfer_rate = 0.9),
                throws_error("not greater than or equal to"))
})

test_that("no provided settings gives error", {
    expect_that(change_account_settings(address = address,
                                        secret = secret),
                throws_error("No settings provided"))
})

transfer_rate = 18/17
domain <- "example.com"
email_hash <- "B58996C504C5638798EB6B511E6F49AF"

result <- change_account_settings(address = address,
                                  secret = secret,
                                  transfer_rate = transfer_rate,
                                  domain = domain,
                                  email_hash = email_hash,
                                  disallow_xrp = T,
                                  require_authorization = F,
                                  require_destination_tag = T)

test_that("classes are correct", {
    expect_that(result, is_a("AccountSettings"))
    expect_that(result@account, is_a("RippleAddress"))
    expect_that(result@regular_key, is_a("RippleAddress"))
    expect_that(result@domain, is_a("character"))
    expect_that(result@email_hash, is_a("Hash128"))
    expect_that(result@message_key, is_a("character"))
    expect_that(result@transfer_rate, is_a("UINT32"))
    expect_that(result@require_destination_tag, is_a("logical"))
    expect_that(result@require_authorization, is_a("logical"))
    expect_that(result@disallow_xrp, is_a("logical"))
    expect_that(result@password_spent, is_a("logical"))
    expect_that(result@disable_master, is_a("logical"))
    expect_that(result@transaction_sequence, is_a("UINT32"))
    expect_that(result@trustline_count, is_a("UINT32"))
    expect_that(result@ledger, is_a("numeric"))
    expect_that(result@hash, is_a("Hash256"))
})

test_that("slot values are correct", {
    expect_that(result@account, equals(address))
    expect_that(result@transfer_rate,
                equals(UINT32(round(transfer_rate * 1e9))))
    expect_that(result@domain, equals(domain))
    expect_that(result@email_hash, equals(Hash128(email_hash)))
    expect_that(result@disallow_xrp, is_true())
    expect_that(result@require_authorization, is_false())
    expect_that(result@require_destination_tag, is_true())
})
