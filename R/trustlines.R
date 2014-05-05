#' Get trustlines
#'
#' Get an account's existing trustlines
#'
#' @param address Account address
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @export
get_account_trustlines <- function(address, ...) {
    path <- paste0("v1/accounts/", address, "/trustlines")
    .GET(path, ...)
}
