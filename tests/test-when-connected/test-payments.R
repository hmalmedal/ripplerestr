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
    expect_that(result, is_a("Payment"))
    expect_that(result@source_account, is_a("RippleAddress"))
    expect_that(result@source_tag, is_a("UINT32"))
    expect_that(result@source_amount, is_a("Amount"))
    expect_that(result@source_slippage, is_a("numeric"))
    expect_that(result@destination_account, is_a("RippleAddress"))
    expect_that(result@destination_tag, is_a("UINT32"))
    expect_that(result@destination_amount, is_a("Amount"))
    expect_that(result@invoice_id, is_a("Hash256"))
    expect_that(result@paths, is_a("character"))
    expect_that(result@partial_payment, is_a("logical"))
    expect_that(result@no_direct_ripple, is_a("logical"))
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

test_that("query parameters don't give errors", {
    expect_that(get_payment_paths(address = address,
                                  destination_account = destination_account,
                                  destination_amount = destination_amount,
                                  source_currencies = "JPY,EUR"),
                not(throws_error()))
    amounts <- Amount(1:2, c("EUR", "JPY"))
    expect_that(get_payment_paths(address = address,
                                  destination_account = destination_account,
                                  destination_amount = destination_amount,
                                  source_currencies = amounts),
                not(throws_error()))
})

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"
destination_account <- RippleAddress("rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X")

value  <- 0.01 / 3
currency <- Currency("USD")
destination_amount <- Amount(value = value,
                             currency = currency)

paths <- get_payment_paths(address = address,
                           destination_account = destination_account,
                           destination_amount = destination_amount)
payment <- paths[1]
payment <- setSourceTag(payment, 2^32-1)
source_slippage(payment) <- 1
payment <- setDestinationTag(payment, 2^31-1)
invoice_id(payment) <- "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
partial_payment(payment) <- T
no_direct_ripple(payment) <- F
uuid <- generate_uuid()

response <- submit_payment(payment = payment,
                           secret = secret,
                           client_resource_id = uuid)

test_that("classes are correct", {
    expect_that(response, is_a("list"))
    expect_that(response$client_resource_id, is_a("character"))
    expect_that(response$status_url, is_a("character"))
})

status <- check_payment_status(status_url = response$status_url)

test_that("classes are correct", {
    expect_that(status, is_a("Payment"))
    expect_that(status@direction, is_a("character"))
    expect_that(status@state, is_a("character"))
    expect_that(status@result, is_a("character"))
    expect_that(status@ledger, is_a("numeric"))
    expect_that(status@hash, is_a("Hash256"))
    expect_that(status@timestamp, is_a("POSIXct"))
    expect_that(status@fee, is_a("numeric"))
    expect_that(status@source_balance_changes, is_a("Amount"))
    expect_that(status@destination_balance_changes, is_a("Amount"))
})

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")

test_that("classes are correct", {
    result <- get_account_payments(address = address)
    expect_that(result, is_a("list"))
    expect_that(result[[1]], is_a("Payment"))
    expect_that(result[[1]]@direction, is_a("character"))
    expect_that(result[[1]]@state, is_a("character"))
    expect_that(result[[1]]@result, is_a("character"))
    expect_that(result[[1]]@ledger, is_a("numeric"))
    expect_that(result[[1]]@hash, is_a("Hash256"))
    expect_that(result[[1]]@timestamp, is_a("POSIXct"))
    expect_that(result[[1]]@fee, is_a("numeric"))
    expect_that(result[[1]]@source_balance_changes, is_a("Amount"))
    expect_that(result[[1]]@destination_balance_changes, is_a("Amount"))
})

account <- RippleAddress("rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X")

test_that("query parameters don't give errors", {
    expect_that(get_account_payments(address,
                                     source_account = account),
                not(throws_error()))
    expect_that(get_account_payments(address,
                                     destination_account = account),
                not(throws_error()))
    expect_that(get_account_payments(address,
                                     exclude_failed = T),
                not(throws_error()))
    expect_that(get_account_payments(address,
                                     direction = "incoming"),
                not(throws_error()))
    expect_that(get_account_payments(address,
                                     source_account = account,
                                     results_per_page = 2,
                                     page = 2),
                not(throws_error()))
})

test_that("invalid direction throws error", {
    expect_that(get_account_payments(address,
                                     direction = "down"),
                throws_error())
})

test_that("number of results per page is correct", {
    expect_that(length(get_account_payments(address)), equals(10))
    expect_that(length(get_account_payments(address, results_per_page = 10)),
                equals(10))
    expect_that(length(get_account_payments(address, results_per_page = 5)),
                equals(5))
})
