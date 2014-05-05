#' Reviewing Trustlines
#'
#' Retrieves all trustlines associated with the Ripple address.
#'
#' @param address The Ripple address of the desired account
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @export
get_account_trustlines <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/trustlines")
    .GET(path, ...)
}
