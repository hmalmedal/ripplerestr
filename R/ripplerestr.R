#' Ripple REST Client for R
#'
#' @name ripplerestr
#' @docType package
#' @import httr
NULL

# Helper functions from httr vignette.
.GET <- function(path, ...) {
    req <- GET("http://localhost:5990/", path = path, ...)
    .check(req)
    .success(req)

    req
}

.success <- function(req) {
    if (.parse(req)$success)
        return(invisible())
    else
        stop(.parse(req)$message, call. = FALSE)
}

.check <- function(req) {
    if (req$status_code < 400)
        return(invisible())

    if (req$status_code == 404)
        stop("HTTP failure: 404\n", content(req, as = "text"), call. = FALSE)

    message <- .parse(req)$message
    stop("HTTP failure: ", req$status_code, "\n", message, call. = FALSE)
}

.parse <- function(req) {
    text <- content(req, as = "text")
    if (identical(text, ""))
        stop("No output to parse", call. = FALSE)
    jsonlite::fromJSON(text, simplifyVector = FALSE)
}

#' Get balances
#'
#' Get an account's existing balances. This includes XRP balance (which does not
#' include a counterparty) and trustline balances.
#'
#' @param address Account address
#' @param currency The balance's currency
#' @param counterparty Counterparty (issuer) of balance
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{server_connected}} for details.
#'
#' @export
account_balances <- function(address, currency = NULL,
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

    path <- paste0("v1/accounts/", address, "/balances")
    .GET(path, query = query, ...)
}

#' Get trustlines
#'
#' Get an account's existing trustlines
#'
#' @param address Account address
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{server_connected}} for details.
#'
#' @export
get_account_trustlines <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/trustlines")
    .GET(path, ...)
}

#' Get settings
#'
#' Get an account's settings
#'
#' @param address Account address
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{server_connected}} for details.
#'
#' @export
get_account_settings <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/settings")
    .GET(path, ...)
}
