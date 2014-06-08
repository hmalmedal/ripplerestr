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
    value <- as.numeric(value)

    currency <- sapply(payments,
                       function(element) element$source_amount$currency)
    currency <- Currency(currency)

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
    destination_amount.value <- as.numeric(destination_amount.value)

    destination_amount.currency <-
        sapply(payments,
               function(element) element$destination_amount$currency)
    destination_amount.currency <- Currency(destination_amount.currency)

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
