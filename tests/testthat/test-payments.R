context("payments")

skip_unconnected <- function() {
    if(!is_server_connected()) skip("Server is not connected.")
}

address <- RippleAddress("r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59")
destination_account <- address
value  <- 0.01 / 3
currency <- Currency("USD")
issuer <- RippleAddress("rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B")
destination_amount <- Amount(value = value,
                             currency = currency,
                             issuer = issuer)

test_that("get_payment_paths", {
    skip_unconnected()

    Sys.sleep(1)
    result <- get_payment_paths(address = address,
                                destination_account = destination_account,
                                destination_amount = destination_amount)

    expect_is(result, "Payment")
    expect_is(result@source_account, "RippleAddress")
    expect_is(result@source_tag, "UINT32")
    expect_is(result@source_amount, "Amount")
    expect_is(result@source_slippage, "numeric")
    expect_is(result@destination_account, "RippleAddress")
    expect_is(result@destination_tag, "UINT32")
    expect_is(result@destination_amount, "Amount")
    expect_is(result@invoice_id, "Hash256")
    expect_is(result@paths, "character")
    expect_is(result@partial_payment, "logical")
    expect_is(result@no_direct_ripple, "logical")

    n <- length(result)

    expect_equal(n, length(result@source_account))
    expect_equal(n, length(result@source_tag))
    expect_equal(n, length(result@source_amount))
    expect_equal(n, length(result@source_slippage))
    expect_equal(n, length(result@destination_account))
    expect_equal(n, length(result@destination_tag))
    expect_equal(n, length(result@destination_amount))
    expect_equal(n, length(result@invoice_id))
    expect_equal(n, length(result@paths))
    expect_equal(n, length(result@partial_payment))
    expect_equal(n, length(result@no_direct_ripple))
})

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"
destination_account <- RippleAddress("rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X")

value  <- 0.01 / 3
currency <- Currency("USD")
destination_amount <- Amount(value = value,
                             currency = currency)

test_that("submit_payment & check_payment_status", {
    skip_unconnected()

    Sys.sleep(1)
    paths <- get_payment_paths(address = address,
                               destination_account = destination_account,
                               destination_amount = destination_amount)
    payment <- paths[1]
    source_tag(payment) <- 2^32-1
    source_slippage(payment) <- 1
    destination_tag(payment) <- 2^31-1
    invoice_id(payment) <- "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    partial_payment(payment) <- TRUE
    no_direct_ripple(payment) <- FALSE
    uuid <- generate_uuid()
    Sys.sleep(1)
    response <- submit_payment(payment = payment,
                               secret = secret,
                               client_resource_id = uuid)

    expect_is(response, "list")
    expect_is(response$client_resource_id, "character")
    expect_is(response$status_url, "character")

    Sys.sleep(1)
    status <- check_payment_status(status_url = response$status_url)

    expect_is(status, "Payment")
    expect_is(status@direction, "character")
    expect_is(status@state, "character")
    expect_is(status@result, "character")
    expect_is(status@ledger, "numeric")
    expect_is(status@hash, "Hash256")
    expect_is(status@timestamp, "POSIXct")
    expect_is(status@fee, "numeric")
    expect_is(status@source_balance_changes, "Amount")
    expect_is(status@destination_balance_changes, "Amount")
})

address <- RippleAddress("rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd")

test_that("get_account_payments", {
    skip_unconnected()

    Sys.sleep(1)
    result <- get_account_payments(address = address)

    expect_is(result, "list")
    expect_is(result[[1]], "Payment")
    expect_is(result[[1]]@direction, "character")
    expect_is(result[[1]]@state, "character")
    expect_is(result[[1]]@result, "character")
    expect_is(result[[1]]@ledger, "numeric")
    expect_is(result[[1]]@hash, "Hash256")
    expect_is(result[[1]]@timestamp, "POSIXct")
    expect_is(result[[1]]@fee, "numeric")
    expect_is(result[[1]]@source_balance_changes, "Amount")
    expect_is(result[[1]]@destination_balance_changes, "Amount")
})

account <- RippleAddress("rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X")

test_that("invalid direction throws error", {
    expect_error(get_account_payments(address, direction = "down"), "direction")
})

test_that("number of results per page is correct", {
    skip_unconnected()
    expect_equal(length(get_account_payments(address)), 10)
    expect_equal(length(get_account_payments(address, results_per_page = 10)),
                 10)
    expect_equal(length(get_account_payments(address, results_per_page = 5)), 5)
})
