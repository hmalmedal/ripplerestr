library(ripplerestr)
context("payments")

address <- RippleAddress("r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59")
destination_account <- address
value  <- 0.01 / 3
currency <- Currency("USD")
issuer <- RippleAddress("rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B")
destination_amount <- Amount(value = value,
                             currency = currency,
                             issuer = issuer)

result <- get_payment_paths(address = address,
                            destination_account = destination_account,
                            destination_amount = destination_amount)

test_that("classes are correct", {
    expect_that(is(result, "Payment"), is_true())
    expect_that(is(result@source_account, "RippleAddress"), is_true())
    expect_that(is(result@source_tag, "UINT32"), is_true())
    expect_that(is(result@source_amount, "Amount"), is_true())
    expect_that(is(result@source_slippage, "numeric"), is_true())
    expect_that(is(result@destination_account, "RippleAddress"), is_true())
    expect_that(is(result@destination_tag, "UINT32"), is_true())
    expect_that(is(result@destination_amount, "Amount"), is_true())
    expect_that(is(result@invoice_id, "Hash256"), is_true())
    expect_that(is(result@paths, "character"), is_true())
    expect_that(is(result@partial_payment, "logical"), is_true())
    expect_that(is(result@no_direct_ripple, "logical"), is_true())
})
