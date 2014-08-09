#' Reviewing Trustlines
#'
#' Retrieves all trustlines associated with the Ripple address.
#'
#' The parameters \code{currency} and \code{counterparty} are supported to
#' provide additional filtering.
#'
#' @param address The Ripple address of the desired account
#' @param currency Three letter currency denominations
#' @param counterparty The Ripple address of the counterparty trusted
#'
#' @return An object of class \code{"\link{Trustline}"}
#'
#' @export
get_account_trustlines <- function(address, currency, counterparty) {
    address <- RippleAddress(address)
    assert_that(is.string(address))

    currency_query <- ""
    counterparty_query <- ""

    if (!missing(currency)) {
        currency <- Currency(currency)
        assert_that(is.string(currency))
        currency_query <- paste0("currency=", currency)
    }

    if (!missing(counterparty)) {
        counterparty <- RippleAddress(counterparty)
        assert_that(is.string(counterparty))
        counterparty_query <- paste0("counterparty=", counterparty)
    }

    query <- paste(currency_query, counterparty_query, sep = "&")
    query <- gsub("^&+|&+$", "", query)
    if (query == "") query <- NULL

    path <- paste0("v1/accounts/", address, "/trustlines")
    req <- .GET(path, query = query)
    trustlines <- .parse(req)$trustlines

    if (length(trustlines) == 0) return(Trustline())

    account <- sapply(trustlines, getElement, "account")
    n <- length(account)
    account <- RippleAddress(account)
    counterparty <- sapply(trustlines, getElement, "counterparty")
    counterparty <- RippleAddress(counterparty)
    currency <- sapply(trustlines, getElement, "currency")
    currency <- Currency(currency)
    limit <- sapply(trustlines, getElement, "limit")
    limit <- as.numeric(limit)

    reciprocated_limit <- sapply(trustlines, getElement, "reciprocated_limit")

    # Check for bug in old version of ripple-rest.
    if (is.null(reciprocated_limit[[1]]))
        reciprocated_limit <- sapply(trustlines, getElement,
                                     "reciprocated__limit")

    reciprocated_limit <- as.numeric(reciprocated_limit)

    account_allows_rippling <- sapply(trustlines, getElement,
                                      "account_allows_rippling")
    counterparty_allows_rippling <- sapply(trustlines, getElement,
                                           "counterparty_allows_rippling")
    ledger <- rep(NA_real_, n)
    hash <- character(n)
    hash <- Hash256(hash)
    Trustline(account = account,
              counterparty = counterparty,
              currency = currency,
              limit = limit,
              reciprocated_limit = reciprocated_limit,
              account_allows_rippling = account_allows_rippling,
              counterparty_allows_rippling = counterparty_allows_rippling,
              ledger = ledger,
              hash = hash)
}
