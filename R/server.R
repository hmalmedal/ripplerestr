#' Get server info
#'
#' Retrieve information about the \code{ripple-rest} and connected
#' \code{rippled}'s current status.
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

#' Get connected state
#'
#' A simple endpoint that can be used to check if \code{ripple-rest} is
#' connected to a \code{rippled} and is ready to serve. If used before querying
#' the other endpoints this can be used to centralize the logic to handle if
#' \code{rippled} is disconnected from the Ripple Network and unable to process
#' transactions.
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
#' is_server_connected(scheme = "https", hostname = "example.com", port = 80)}
#'
#' @return TRUE or FALSE
#'
#' @export
is_server_connected <- function(...) {
    path <- "v1/server/connected"
    req <- .GET(path, ...)
    .parse(req)$connected
}
