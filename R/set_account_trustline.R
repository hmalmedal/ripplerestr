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
#'
#' @return An object of class \code{"\link{Trustline}"}
#'
#' @export
set_account_trustline <- function(address, secret, amount,
                                  allows_rippling = NA, limit, currency,
                                  counterparty) {
    address <- RippleAddress(address)
    assert_that(is.string(address))
    assert_that(is.string(secret))
    assert_that(is.flag(allows_rippling))

    if (!missing(amount)) {
        assert_that(is(amount, "Amount"))
        assert_that(is.scalar(amount))
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
    body <- list(secret = secret, trustline = trustline)
    body <- toJSON(body, auto_unbox = TRUE)
    path <- paste0("v1/accounts/", address, "/trustlines")
    req <- .POST(path, body)
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
