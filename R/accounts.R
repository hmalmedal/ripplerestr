#' Account Balances
#'
#' Retrieve the current balances for the given Ripple account.
#'
#' @param address The Ripple address of the desired account
#' @param currency Three letter currency denominations
#' @param counterparty The Ripple address of the counterparty trusted
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @export
get_account_balances <- function(address, currency = NULL,
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

#' Account Settings
#'
#' You can retrieve an account's settings. The server will return a list of the
#' current settings in force for the given account.
#'
#' @param address The Ripple address of the desired account
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @export
get_account_settings <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/settings")
    .GET(path, ...)
}
