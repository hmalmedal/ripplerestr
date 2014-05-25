#' Preparing a Payment
#'
#' To prepare a payment, you first make a call to this endpoint. This will
#' generate a list of possible payments between the two parties for the desired
#' amount, taking into account the established trustlines between the two
#' parties for the currency being transferred. You can then choose one of the
#' returned payments, modify it if necessary (for example, to set slippage
#' values or tags), and then submit the payment for processing.
#'
#' @param address The Ripple address for the source account.
#' @param destination_account The Ripple address for the destination account.
#' @param destination_amount An object of class \code{"\link{Amount}"}. The
#'   amount to be sent to the destination account.
#' @param value The quantity of the currency. Ignored if
#'   \code{destination_amount} is provided.
#' @param currency The currency expressed as a three-character code. Ignored if
#'   \code{destination_amount} is provided.
#' @param issuer The Ripple account address of the currency's issuer or gateway,
#'   or an empty string if the currency is XRP. Ignored if
#'   \code{destination_amount} is provided.
#' @param source_currencies A string or an object of class
#'   \code{"\link{Amount}"}. This is used to filter the returned list of
#'   possible payments. Each source currency can be specified either as a
#'   currency code, or as a currency code and issuer. If the issuer is not
#'   specified for a currency other than XRP, then the results will be limited
#'   to the specified currency, but any issuer for that currency will be
#'   included in the results. The string should be a comma-separated list of
#'   source currencies. Each source currency can be specified either as a
#'   currency code (eg, \code{USD}), or as a currency code and issuer (eg,
#'   \code{USD+r...}).
#'
#' @return An object of class \code{"\link{Payment}"}
#'
#' @export
get_payment_paths <- function(address, destination_account,
                              destination_amount, value, currency,
                              issuer = "", source_currencies) {
    address <- RippleAddress(address)
    assert_that(is.string(address))
    destination_account <- RippleAddress(destination_account)
    assert_that(is.string(destination_account))

    if (!missing(destination_amount)) {
        assert_that(is(destination_amount, "Amount"))
        assert_that(is.scalar(destination_amount))
        value <- destination_amount@value
        currency <- destination_amount@currency
        issuer <- destination_amount@issuer
        if (issuer == "")
            issuer <- destination_amount@counterparty
    }

    assert_that(is.number(value))
    currency <- Currency(currency)
    assert_that(is.string(currency))
    assert_that(is.string(issuer))

    query <- NULL

    if (!missing(source_currencies)) {
        if (!is(source_currencies, "Amount")) {
            assert_that(is.string(source_currencies))
        } else {
            source_currencies <- paste(gsub("^[^\\+]*\\+",
                                            "",
                                            source_currencies),
                                       collapse = ",")
        }
        query <- paste0("source_currencies=", source_currencies)
    }

    destination_amount <- paste(value, currency, issuer, sep = "+")
    destination_amount <- sub("\\+$", "", destination_amount)

    XRP <- Currency("XRP")
    if (identical(currency, XRP))
        destination_amount <- sub("XRP.*$", "XRP", destination_amount)

    path <- paste0("v1/accounts/", address, "/payments/paths/",
                   destination_account, "/", destination_amount)
    req <- .GET(path, query = query)
    payments <- .parse(req)$payments

    if (length(payments) == 0) return(Payment())

    source_account <- sapply(payments,
                             function(element) element$source_account)
    source_account <- RippleAddress(source_account)

    source_tag <- sapply(payments, function(element) element$source_tag)
    source_tag[source_tag == ""] <- NA
    source_tag <- UINT32(source_tag)

    value <- sapply(payments, function(element) element$source_amount$value)
    value  <- as.numeric(value)

    currency <- sapply(payments,
                       function(element) element$source_amount$currency)
    currency  <- Currency(currency)

    issuer <- sapply(payments, function(element) element$source_amount$issuer)

    source_amount <- Amount(value = value,
                            currency = currency,
                            issuer = issuer)

    source_slippage <- sapply(payments,
                              function(element) element$source_slippage)
    source_slippage <- as.numeric(source_slippage)

    destination_account <- sapply(payments,
                                  function(element)
                                      element$destination_account)
    destination_account <- RippleAddress(destination_account)

    destination_tag <- sapply(payments,
                              function(element) element$destination_tag)
    destination_tag[destination_tag == ""] <- NA
    destination_tag <- UINT32(destination_tag)

    destination_amount.value <- sapply(payments,
                                       function(element)
                                           element$destination_amount$value)
    destination_amount.value  <- as.numeric(destination_amount.value)

    destination_amount.currency <-
        sapply(payments,
               function(element) element$destination_amount$currency)
    destination_amount.currency  <- Currency(destination_amount.currency)

    destination_amount.issuer <- sapply(payments,
                                        function(element)
                                            element$destination_amount$issuer)

    destination_amount <- Amount(value = destination_amount.value,
                                 currency = destination_amount.currency,
                                 issuer = destination_amount.issuer)

    invoice_id <- sapply(payments, function(element) element$invoice_id)
    invoice_id <- Hash256(invoice_id)

    paths <- sapply(payments, function(element) element$paths)

    partial_payment <- sapply(payments,
                              function(element) element$partial_payment)

    no_direct_ripple <- sapply(payments,
                               function(element) element$no_direct_ripple)

    Payment(source_account = source_account,
            source_tag = source_tag,
            source_amount = source_amount,
            source_slippage = source_slippage,
            destination_account = destination_account,
            destination_tag = destination_tag,
            destination_amount = destination_amount,
            invoice_id = invoice_id,
            paths = paths,
            partial_payment = partial_payment,
            no_direct_ripple = no_direct_ripple)
}

#' Submitting a Payment
#'
#' Before you can submit a payment, you will need to have three pieces of
#' information.
#'
#' @param payment The \code{"\link{Payment}"} object to be submitted.
#' @param secret The secret or private key for your Ripple account.
#' @param client_resource_id Will uniquely identify this payment. This is a
#'   36-character UUID (universally unique identifier) value which will uniquely
#'   identify this payment within the \code{ripple-rest} API. Note that you can
#'   use \code{\link{generate_uuid}} to calculate a UUID value if you do not
#'   have a UUID generator readily available.
#'
#' @return A named list. The first element is the \code{"client_resource_id"}
#'   you gave. The second element is named \code{"status_url"} and can be used
#'   with \code{\link{check_payment_status}}.
#'
#' @export
submit_payment <- function(payment, secret, client_resource_id) {
    assert_that(is(payment, "Payment"))
    assert_that(is.scalar(payment))
    assert_that(is.string(secret))
    client_resource_id <- ResourceId(client_resource_id)
    assert_that(is.string(client_resource_id))

    source_account <- payment@source_account

    source_tag <- payment@source_tag
    if (is.na(source_tag))
        source_tag  <- ""
    else
        source_tag <- as.character(source_tag)

    source_amount <- list(value = as.character(payment@source_amount@value),
                          currency = payment@source_amount@currency,
                          issuer = payment@source_amount@issuer)

    source_slippage = as.character(payment@source_slippage)

    destination_account <- payment@destination_account

    destination_tag <- payment@destination_tag
    if (is.na(destination_tag))
        destination_tag  <- ""
    else
        destination_tag <- as.character(destination_tag)

    destination_amount <-
        list(value = as.character(payment@destination_amount@value),
             currency = payment@destination_amount@currency,
             issuer = payment@destination_amount@issuer)

    invoice_id <- payment@invoice_id
    paths <- payment@paths
    partial_payment <- payment@partial_payment
    no_direct_ripple <- payment@no_direct_ripple

    payment <- list(source_account = source_account,
                    source_tag = source_tag,
                    source_amount = source_amount,
                    source_slippage = source_slippage,
                    destination_account = destination_account,
                    destination_tag = destination_tag,
                    destination_amount = destination_amount,
                    invoice_id = invoice_id,
                    paths = paths,
                    partial_payment = partial_payment,
                    no_direct_ripple = no_direct_ripple)

    body <- list(secret = secret,
                 client_resource_id = client_resource_id,
                 payment = payment)
    body <- jsonlite::toJSON(body)
    body <- gsub("\\[ | \\]", "", body)
    path <- "v1/payments"
    req <- .POST(path, body)
    object <- .parse(req)
    object["success"] <- NULL
    object
}

#' Confirming a Payment
#'
#' To confirm that your payment has been submitted successfully, you can call
#' this.
#'
#' @param status_url Return value from \code{\link{submit_payment}}.
#' @param address The Ripple address for the source account. Ignored if
#'   \code{status_url} is provided.
#' @param client_resource_id Provided to \code{\link{submit_payment}}. Ignored
#'   if \code{status_url} is provided.
#' @param hash The transaction hash for the desired payment. Ignored if
#'   \code{status_url} or \code{client_resource_id} is provided.
#'
#' @return An object of class \code{"\link{Payment}"}
#'
#' @export
check_payment_status <- function(status_url, address, client_resource_id,
                                 hash) {
    if (!missing(status_url)) {
        assert_that(is.string(status_url))

        pattern <- paste0("^/v1/accounts/",
                          "r[1-9A-HJ-NP-Za-km-z]{25,33}",
                          "/payments/",
                          "(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$")
        if (!grepl(pattern, status_url, perl = T))
            stop("invalid status_url",  call. = FALSE)

        path <- sub("^/", "", status_url)
    } else {
        address <- RippleAddress(address)
        assert_that(is.string(address))
        path <- paste0("v1/accounts/", address, "/payments/")
        if (!missing(client_resource_id)) {
            client_resource_id <- ResourceId(client_resource_id)
            assert_that(is.string(client_resource_id))
            path <- paste0(path, client_resource_id)
        } else {
            hash <- Hash256(hash)
            assert_that(is.string(hash))
            path <- paste0(path, hash)
        }
    }

    req <- .GET(path)
    payment <- .parse(req)
    .parse_payment(payment)
}

#' Payment History
#'
#' This API endpoint can be used to browse through an account's payment history
#' and also used to confirm specific payments after a payment has been
#' submitted.
#'
#' If the server returns fewer than \code{results_per_page} payments, then there
#' are no more pages of results to be returned. Otherwise, increment the page
#' number and re-issue the query to get the next page of results.
#'
#' Note that the \code{ripple-rest} API has to retrieve the full list of
#' payments from the server and then filter them before returning them back to
#' the caller. This means that there is no speed advantage to specifying more
#' filter values.
#'
#' @param address The Ripple address of the desired account
#' @param source_account Filter the results to only include payments sent by the
#'   given account.
#' @param destination_account Filter the results to only include payments
#'   received by the given account.
#' @param exclude_failed  If set to \code{TRUE}, the results will only include
#'   payments which were successfully validated and written into the ledger.
#'   Otherwise, failed payments will be included. Defaults to \code{FALSE}.
#' @param direction Limit the results to only include the given type of
#'   payments. The following direction values are currently supported:
#'   \code{incoming}, \code{outgoing}, \code{pending}
#' @param earliest_first If set to \code{TRUE}, the payments will be returned in
#'   ascending date order. Otherwise, the payments will be returned in
#'   descending date order (ie, the most recent payment will be returned first).
#'   Defaults to \code{FALSE}.
#' @param start_ledger The index for the starting ledger. If
#'   \code{earliest_first} is \code{TRUE}, this will be the oldest ledger to be
#'   queried; otherwise, it will be the most recent ledger. Defaults to the
#'   first ledger in the \code{rippled} server's database.
#' @param end_ledger The index for the ending ledger. If \code{earliest_first}
#'   is \code{TRUE}, this will be the most recent ledger to be queried;
#'   otherwise, it will be the oldest ledger. Defaults to the most recent ledger
#'   in the \code{rippled} server's database.
#' @param results_per_page The maximum number of payments to be returned at
#'   once. Defaults to 10.
#' @param page The page number to be returned. The first page of results will
#'   have page number 1, the second page will have page number 2, and so on.
#'   Defaults to 1.
#'
#' @return A list of objects of class \code{"\link{Payment}"}
#'
#' @export
get_account_payments <- function(address,
                                 source_account,
                                 destination_account,
                                 exclude_failed = FALSE,
                                 direction,
                                 earliest_first = FALSE,
                                 start_ledger,
                                 end_ledger,
                                 results_per_page = 10,
                                 page = 1) {
    address <- RippleAddress(address)
    assert_that(is.string(address))

    source_account_query <- ""
    if (!missing(source_account)) {
        source_account <- RippleAddress(source_account)
        assert_that(is.string(source_account))
        source_account_query <- paste0("source_account=", source_account)
    }

    destination_account_query <- ""
    if (!missing(destination_account)) {
        destination_account <- RippleAddress(destination_account)
        assert_that(is.string(destination_account))
        destination_account_query <- paste0("destination_account=",
                                            destination_account)
    }

    exclude_failed_query <- ""
    assert_that(is.flag(exclude_failed))
    if (exclude_failed)
        exclude_failed_query <- "exclude_failed=true"

    direction_query <- ""
    if (!missing(direction)) {
        assert_that(is.string(direction))
        if (!grepl("^incoming|outgoing|pending$", direction))
            stop("Invalid direction")
        direction_query <- paste0("direction=", direction)
    }

    earliest_first_query <- ""
    assert_that(is.flag(earliest_first))
    if (earliest_first)
        earliest_first_query <- "earliest_first=true"

    start_ledger_query <- ""
    if (!missing(start_ledger)) {
        assert_that(is.count(start_ledger))
        start_ledger_query <- paste0("start_ledger=", format(start_ledger,
                                                             scientific = F))
    }

    end_ledger_query <- ""
    if (!missing(end_ledger)) {
        assert_that(is.count(end_ledger))
        end_ledger_query <- paste0("end_ledger=", format(end_ledger,
                                                         scientific = F))
    }

    results_per_page_query <- ""
    assert_that(is.count(results_per_page))
    if (results_per_page != 10)
        results_per_page_query <- paste0("results_per_page=",
                                         format(results_per_page,
                                                scientific = F))

    page_query <- ""
    assert_that(is.count(page))
    if (page > 1)
        page_query <- paste0("page=", page)

    query <- paste(source_account_query,
                   destination_account_query,
                   exclude_failed_query,
                   direction_query,
                   earliest_first_query,
                   start_ledger_query,
                   end_ledger_query,
                   results_per_page_query,
                   page_query,
                   sep = "&")

    query <- gsub("&+", "&", query)
    query <- gsub("^&|&$", "", query)
    if (query == "")
        query <- NULL

    path <- paste0("v1/accounts/", address, "/payments")
    req <- .GET(path, query = query)
    payments <- .parse(req)$payments
    lapply(payments, .parse_payment)
}
