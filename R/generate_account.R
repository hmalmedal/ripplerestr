#' Generating Accounts
#'
#' There are two steps to making a new account on the Ripple network: randomly
#' creating the keys for that account, and sending it enough XRP to meet the
#' account reserve. Generating the keys can be done offline, since it does not
#' affect the network at all. To make it easy, this function can generate
#' account keys for you.
#'
#' The generated account does not exist in the ledger until it receives enough
#' XRP to meet the account reserve.
#'
#' @return A list with the address and the secret for a potential new account
#'
#' @export
generate_account <- function() {
    path <- "v1/accounts/new"
    req <- .GET(path)
    .parse(req)$account
}
