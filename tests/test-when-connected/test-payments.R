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

test_that("slot lengths are equal to object length", {
    n <- length(result)
    expect_that(n, equals(length(result@source_account)))
    expect_that(n, equals(length(result@source_tag)))
    expect_that(n, equals(length(result@source_amount)))
    expect_that(n, equals(length(result@source_slippage)))
    expect_that(n, equals(length(result@destination_account)))
    expect_that(n, equals(length(result@destination_tag)))
    expect_that(n, equals(length(result@destination_amount)))
    expect_that(n, equals(length(result@invoice_id)))
    expect_that(n, equals(length(result@paths)))
    expect_that(n, equals(length(result@partial_payment)))
    expect_that(n, equals(length(result@no_direct_ripple)))
})

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"
destination_account <- RippleAddress("rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X")
root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")

value  <- 0.01 / 3
currency <- Currency("USD")
destination_amount <- Amount(value = value,
                             currency = currency,
                             issuer = root_account)

paths <- get_payment_paths(address = address,
                           destination_account = destination_account,
                           destination_amount = destination_amount)
payment <- paths[1]
payment@source_tag <- UINT32(2^32-1)
payment@source_slippage <- 1
payment@destination_tag <- UINT32(2^31-1)
payment@invoice_id <- Hash256("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
payment@partial_payment  <- T
uuid <- generate_uuid()

response <- submit_payment(payment = payment, secret = secret, client_resource_id = uuid)

status <- check_payment_status(status_url = response$status_url)
