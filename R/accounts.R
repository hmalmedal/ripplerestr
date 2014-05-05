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

#' Get settings
#'
#' Get an account's settings
#'
#' @param address Account address
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @export
get_account_settings <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/settings")
    .GET(path, ...)
}
