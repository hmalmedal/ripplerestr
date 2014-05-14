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
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return A list
#'
#' @export
submit_payment <- function(payment, secret, client_resource_id, ...) {
    assert_that(is(payment, "Payment"))
    assert_that(is.scalar(payment))
    assert_that(is.string(secret))
    assert_that(is(client_resource_id, "ResourceId"))
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

    paymentlist <- list(source_account = source_account,
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

    bodylist <- list(secret = secret,
                     client_resource_id = client_resource_id,
                     payment = paymentlist)
    body <- jsonlite::toJSON(bodylist)
    body <- gsub("\\[ | \\]", "", body)
    path <- "v1/payments"
    req <- .POST(path, body, ...)
    object <- .parse(req)
    object["success"] <- NULL
    object
}

#' Confirming a Payment
#' 
#' @return An object of class \code{"\link{Payment}"}
#'
#' @export
check_payment_status <- function(status_url, ...) {
    if (!missing(status_url)) {
        assert_that(is.string(status_url))
        
        if(!grepl("^/v1/accounts/r[1-9A-HJ-NP-Za-km-z]{25,33}/payments/(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$",
                  status_url, perl = T))
            stop("invalid status_url",  call. = FALSE)
        
        path <- sub("^/", "", status_url)
    }
    req <- .GET(path, ...)
    paymentlist <- .parse(req)$payment
    
    source_account <- RippleAddress(paymentlist$source_account)
    source_tag <- UINT32(paymentlist$source_tag)
    source_amount <- 
        Amount(value = paymentlist$source_amount$value,
               currency = 
                   Currency(paymentlist$source_amount$currency),
               issuer = paymentlist$source_amount$issuer)
    source_slippage <- as.numeric(paymentlist$source_slippage)
    destination_account <- RippleAddress(paymentlist$destination_account)
    destination_tag <- UINT32(paymentlist$destination_tag)
    destination_amount <- 
        Amount(value = paymentlist$destination_amount$value,
               currency = 
                   Currency(paymentlist$destination_amount$currency),
               issuer = paymentlist$destination_amount$issuer)
    invoice_id <- Hash256(paymentlist$invoice_id)
    paths <- paymentlist$paths
    partial_payment <- paymentlist$partial_payment
    no_direct_ripple <- paymentlist$no_direct_ripple
    direction <- paymentlist$direction
    state <- paymentlist$state
    result <- paymentlist$result
    ledger <- as.numeric(paymentlist$ledger)
    hash <- Hash256(paymentlist$hash)
    timestamp <- ymd_hms(paymentlist$timestamp, quiet = T)
    fee <- as.numeric(paymentlist$fee)

    source_balance_changes.value <- 
        sapply(paymentlist$source_balance_changes,
               function(element) element$value)
    source_balance_changes.value <- 
        as.numeric(source_balance_changes.value)
    source_balance_changes.currency <- 
        sapply(paymentlist$source_balance_changes,
               function(element) element$currency)
    source_balance_changes.currency <- 
        Currency(source_balance_changes.currency)
    source_balance_changes.issuer <- 
        sapply(paymentlist$source_balance_changes,
               function(element) element$issuer)
    source_balance_changes <- 
        Amount(value = source_balance_changes.value,
               currency = source_balance_changes.currency,
               issuer = source_balance_changes.issuer)
    
    destination_balance_changes.value <- 
        sapply(paymentlist$destination_balance_changes,
               function(element) element$value)
    destination_balance_changes.value <- 
        as.numeric(destination_balance_changes.value)
    destination_balance_changes.currency <- 
        sapply(paymentlist$destination_balance_changes,
               function(element) element$currency)
    destination_balance_changes.currency <- 
        Currency(destination_balance_changes.currency)
    destination_balance_changes.issuer <- 
        sapply(paymentlist$destination_balance_changes,
               function(element) element$issuer)
    destination_balance_changes <- 
        Amount(value = destination_balance_changes.value,
               currency = destination_balance_changes.currency,
               issuer = destination_balance_changes.issuer)
    

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
            no_direct_ripple = no_direct_ripple,
            direction = direction,
            state = state,
            result = result,
            ledger = ledger,
            hash = hash,
            timestamp = timestamp,
            fee = fee,
            source_balance_changes = source_balance_changes,
            destination_balance_changes = destination_balance_changes)
}
