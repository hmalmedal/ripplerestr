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
#'   included in the results.
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return An object of class \code{"\link{Payment}"}
#'
#' @export
get_payment_paths <- function(address,
                              destination_account,
                              destination_amount,
                              value, currency, issuer,
                              source_currencies, ...) {
    address <- RippleAddress(address)
    assert_that(is.string(address))
    destination_account <- RippleAddress(destination_account)
    assert_that(is.string(destination_account))

    if (!missing(destination_amount)) {
        assert_that(is(destination_amount, "Amount"))
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
        if(!is(source_currencies, "Amount")) {
            assert_that(is.string(source_currencies))
            query <- paste0("source_currencies=", source_currencies)
        }
    }

    destination_amount_string <- paste(value, currency, issuer, sep = "+")
    destination_amount_string <- sub("\\+$", "",
                                     destination_amount_string)

    XRP <- Currency("XRP")
    if(identical(currency, XRP))
        destination_amount_string <- sub("XRP.*$", "XRP",
                                         destination_amount_string)

    path <- paste0("v1/accounts/", address, "/payments/paths/",
                   destination_account, "/", destination_amount_string)
    req <- .GET(path, query = query, ...)
    list_of_payments <- .parse(req)$payments

    if (length(list_of_payments) == 0) return(Payment())

    source_accounts <- sapply(list_of_payments,
                              function(element) element$source_account)
    source_accounts <- RippleAddress(source_accounts)

    source_tags <- sapply(list_of_payments,
                          function(element) element$source_tag)
    source_tags[source_tags == ""] <- NA
    source_tags <- UINT32(source_tags)

    source_amounts.values <- sapply(list_of_payments,
                                    function(element)
                                        element$source_amount$value)
    source_amounts.values  <- as.numeric(source_amounts.values)

    source_amounts.currencies <- sapply(list_of_payments,
                                        function(element)
                                            element$source_amount$currency)
    source_amounts.currencies  <- Currency(source_amounts.currencies)

    source_amounts.issuers <- sapply(list_of_payments,
                                     function(element)
                                         element$source_amount$issuer)

    source_amounts <- Amount(value = source_amounts.values,
                             currency = source_amounts.currencies,
                             issuer = source_amounts.issuers)

    source_slippages <- sapply(list_of_payments,
                               function(element) element$source_slippage)
    source_slippages <- as.numeric(source_slippages)

    destination_accounts <- sapply(list_of_payments,
                                   function(element)
                                       element$destination_account)
    destination_accounts <- RippleAddress(destination_accounts)

    destination_tags <- sapply(list_of_payments,
                               function(element) element$destination_tag)
    destination_tags[destination_tags == ""] <- NA
    destination_tags <- UINT32(destination_tags)

    destination_amounts.values <- sapply(list_of_payments,
                                         function(element)
                                             element$destination_amount$value)
    destination_amounts.values  <- as.numeric(destination_amounts.values)

    destination_amounts.currencies <-
        sapply(list_of_payments,
               function(element)
                   element$destination_amount$currency)
    destination_amounts.currencies  <- Currency(destination_amounts.currencies)

    destination_amounts.issuers <- sapply(list_of_payments,
                                          function(element)
                                              element$destination_amount$issuer)

    destination_amounts <- Amount(value = destination_amounts.values,
                                  currency = destination_amounts.currencies,
                                  issuer = destination_amounts.issuers)

    invoice_ids <- sapply(list_of_payments,
                          function(element) element$invoice_id)
    invoice_ids <- Hash256(invoice_ids)

    paths_vector <- sapply(list_of_payments,
                           function(element) element$paths)

    partial_payment_vector <- sapply(list_of_payments,
                                     function(element)
                                         element$partial_payment)

    no_direct_ripple_vector <- sapply(list_of_payments,
                                      function(element)
                                          element$no_direct_ripple)

    Payment(source_account = source_accounts,
            source_tag = source_tags,
            source_amount = source_amounts,
            source_slippage = source_slippages,
            destination_account = destination_accounts,
            destination_tag = destination_tags,
            destination_amount = destination_amounts,
            invoice_id = invoice_ids,
            paths = paths_vector,
            partial_payment = partial_payment_vector,
            no_direct_ripple = no_direct_ripple_vector)
}
