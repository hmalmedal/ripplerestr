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
get_account_trustlines <- function(address, currency,
                                   counterparty, ...) {
    address <- RippleAddress(address)
    assert_that(is.string(address))

    query <- NULL

    if (!missing(counterparty)) {
        counterparty <- RippleAddress(counterparty)
        assert_that(is.string(counterparty))
    }

    if (!missing(currency)) {
        currency <- Currency(currency)
        assert_that(is.string(currency))
        query <- paste0("currency=", currency)
        if (!missing(counterparty))
            query <- paste0(query, "&counterparty=", counterparty)
    } else if (!missing(counterparty))
        query <- paste0("counterparty=", counterparty)

    path <- paste0("v1/accounts/", address, "/trustlines")
    req <- .GET(path, query = query, ...)
    trustlines <- .parse(req)$trustlines

    if(length(trustlines) == 0) return(Trustline())

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

#' Granting a Trustline
#'
#' A trustline can also updated and simply set with a currency, amount,
#' counterparty combination by submitting to this endpoint.
#'
#' @param address The Ripple address of the desired account
#' @param secret The secret key for your Ripple account.
#' @param amount Object of class \code{"\link{Amount}"}. The limit, currency and
#'   counterparty for the trustline.
#' @param allows_rippling \code{TRUE} or \code{FALSE}. Allow rippling or not for
#'   the trustline.
#' @param limit A number indicating the maximum you are willing to trust.
#'   Ignored if \code{amount} is provided.
#' @param currency Three letter currency denomination. Ignored if \code{amount}
#'   is provided.
#' @param counterparty Ripple address of the counterparty trusted. Ignored if
#'   \code{amount} is provided.
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return An object of class \code{"\link{Trustline}"}
#'
#' @export
set_account_trustline <- function(address, secret,
                                  amount,
                                  allows_rippling = NA,
                                  limit, currency,
                                  counterparty, ...) {
    address <- RippleAddress(address)
    assert_that(is.string(address))
    assert_that(is.string(secret))
    assert_that(is.flag(allows_rippling))

    if (!missing(amount)) {
        assert_that(is(amount, "Amount"))
        limit <- amount@value
        currency <- amount@currency
        counterparty <- amount@counterparty
        if (counterparty == "")
            counterparty <- amount@issuer
    }

    assert_that(is.number(limit))
    currency <- Currency(currency)
    assert_that(is.string(currency))
    counterparty <- RippleAddress(counterparty)
    assert_that(is.string(counterparty))

    trustline <- list(limit = as.character(limit),
                      currency = currency,
                      counterparty = counterparty)
    if (!is.na(allows_rippling))
        trustline <- c(trustline, list(allows_rippling = allows_rippling))
    bodylist <- list(secret = secret, trustline = trustline)
    body <- jsonlite::toJSON(bodylist)
    body <- gsub("\\[|\\]", "", body)
    path <- paste0("v1/accounts/", address, "/trustlines")
    req <- .POST(path, body, ...)
    result <- .parse(req)

    Trustline(account = RippleAddress(result$trustline$account),
              counterparty = RippleAddress(result$trustline$counterparty),
              currency = Currency(result$trustline$currency),
              limit = as.numeric(result$trustline$limit),
              reciprocated_limit = NA_real_,
              account_allows_rippling =
                  result$trustline$account_allows_rippling,
              counterparty_allows_rippling = NA,
              ledger = as.numeric(result$ledger),
              hash = Hash256(result$hash))
}
