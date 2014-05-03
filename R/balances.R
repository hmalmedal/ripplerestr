#' Get balances
#' 
#' Get an account's existing balances. This includes XRP balance (which does not
#' include a counterparty) and trustline balances.
#'
#' @export
account_balances <- function(address, server = "http://localhost:5990") {
    endpoint <- paste0("/v1/accounts/", address, "/balances")
    url  <- paste0(server, endpoint)
    return(content(GET(url)))
}
#' Get trustlines
#' 
#' Get an account's existing trustlines
#'
#' @export
get_account_trustlines <- function(address,
                                   server = "http://localhost:5990") {
    endpoint <- paste0("/v1/accounts/", address, "/trustlines")
    url  <- paste0(server, endpoint)
    return(content(GET(url)))
}
