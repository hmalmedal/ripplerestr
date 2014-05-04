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

#' Get server info
#'
#' Retrieve information about the \code{ripple-rest} and connected
#' \code{rippled}'s current status.
#'
#' @export
server_status <- function(...) {
    path <- "v1/server"
    .GET(path, ...)
}

#' Get connected state
#'
#' A simple endpoint that can be used to check if \code{ripple-rest} is
#' connected to a \code{rippled} and is ready to serve. If used before querying
#' the other endpoints this can be used to centralize the logic to handle if
#' \code{rippled} is disconnected from the Ripple Network and unable to process
#' transactions.
#'
#' @return TRUE or FALSE
#'
#' @export
server_connected <- function(...) {
    path <- "v1/server/connected"
    req <- .GET(path, ...)
    .parse(req)$connected
}

#' Get UUID
#'
#' A UUID v4 generator, which can be used if the client wishes to use UUIDs for
#' the \code{client_resource_id} but does not have a UUID generator handy.
#'
#' @export
uuid_generator <- function(...) {
    path <- "v1/uuid"
    .GET(path, ...)
}

#' Get balances
#'
#' Get an account's existing balances. This includes XRP balance (which does not
#' include a counterparty) and trustline balances.
#'
#' @param currency The balance's currency
#' @param counterparty Counterparty (issuer) of balance
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
#' @export
get_account_trustlines <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/trustlines")
    .GET(path, ...)
}

#' Get settings
#'
#' Get an account's settings
#'
#' @export
get_account_settings <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/settings")
    .GET(path, ...)
}
