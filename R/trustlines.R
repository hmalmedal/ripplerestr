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
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return An object of class \code{"\link{Trustline}"}
#'
#' @export
get_account_trustlines <- function(address, currency = NULL,
                                   counterparty = NULL, ...) {
    query <- NULL
    if (!is.null(currency)) {
        query <- paste0("currency=", currency)
        if (!is.null(counterparty)) {
            query <- paste0(query, "&counterparty=", counterparty)
        }
    } else {
        if (!is.null(counterparty)) {
            query <- paste0("counterparty=", counterparty)
        }
    }

    path <- paste0("v1/accounts/", address, "/trustlines")
    req <- .GET(path, query = query, ...)
    trustlines <- .parse(req)$trustlines
    accounts <- sapply(trustlines, function(element) element$account)
    n <- length(accounts)
    accounts <- RippleAddress(accounts)
    counterparties <- sapply(trustlines, function(element) element$counterparty)
    counterparties <- RippleAddress(counterparties)
    currencies <- sapply(trustlines, function(element) element$currency)
    currencies <- Currency(currencies)
    limits <- sapply(trustlines, function(element) element$limit)
    limits <- as.numeric(limits)
    reciprocated_limits <- sapply(trustlines,
                                  function(element) element$reciprocated__limit)
    reciprocated_limits <- as.numeric(reciprocated_limits)
    .account_allows_rippling <-
        sapply(trustlines, function(element) element$account_allows_rippling)
    .counterparty_allows_rippling <-
        sapply(trustlines,
               function(element) element$counterparty_allows_rippling)
    ledgers <- rep(NA_real_, n)
    hashes <- character(n)
    hashes <- Hash256(hashes)
    Trustline(account = accounts,
              counterparty = counterparties,
              currency = currencies,
              limit = limits,
              reciprocated_limit = reciprocated_limits,
              account_allows_rippling = .account_allows_rippling,
              counterparty_allows_rippling = .counterparty_allows_rippling,
              ledger = ledgers,
              hash = hashes)
}
