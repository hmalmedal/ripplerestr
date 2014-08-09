#' Account Balances
#'
#' Retrieve the current balances for the given Ripple account.
#'
#' The parameters \code{currency} and \code{counterparty} are supported to
#' provide additional filtering.
#'
#' @param address The Ripple address of the desired account
#' @param currency Three letter currency denominations
#' @param counterparty The Ripple address of the counterparty trusted
#'
#' @examples
#' root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
#' \dontrun{
#' get_account_balances(root_account)}
#'
#' @return An object of class \code{"\link{Balance}"}
#'
#' @export
get_account_balances <- function(address, currency, counterparty) {
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

    path <- paste0("v1/accounts/", address, "/balances")
    req <- .GET(path, query = query)
    balances <- .parse(req)$balances

    if (length(balances) == 0) return(Balance())

    value <- sapply(balances, getElement, "value")
    value <- as.numeric(value)
    currency <- sapply(balances, getElement, "currency")
    currency <- Currency(currency)
    counterparty <- sapply(balances, getElement, "counterparty")
    Balance(value = value,
            currency = currency,
            counterparty = counterparty)
}
