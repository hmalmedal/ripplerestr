#' Get Server Status
#'
#' Retrieve information about the current status of the \code{ripple-rest} API
#' and the \code{rippled} server it is connected to.
#'
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'   See \code{\link{is_server_connected}} for details.
#'
#' @return A list of lists
#'
#' @export
get_server_status <- function(...) {
    path <- "v1/server"
    req <- .GET(path, ...)
    object <- .parse(req)
    object["success"] <- NULL
    object
}

#' Check Connection State
#'
#' Checks to see if the \code{ripple-rest} API is currently connected to a
#' \code{rippled} server, and is ready to be used. This provides a quick and
#' easy way to check to see if the API is up and running, before attempting to
#' process transactions.
#'
#' The default base url is \code{http://localhost:5990/}. This can be changed
#' via ellipsis.
#'
#' @param ... Named parameters – such as \code{scheme}, \code{hostname} and
#'   \code{port} – passed on to \code{\link{httr}}'s \code{\link{modify_url}}.
#'
#' @examples
#' \dontrun{
#' # Use https://example.com:80/
#' is_server_connected(scheme = "https", hostname = "example.com", port = 80)
#' # alternatively
#' host <- list(scheme = "https", hostname = "example.com", port = 80)
#' do.call(is_server_connected, host)}
#'
#' @return \code{TRUE} or \code{FALSE}
#'
#' @export
is_server_connected <- function(...) {
    path <- "v1/server/connected"
    req <- .GET(path, ...)
    .parse(req)$connected
}
