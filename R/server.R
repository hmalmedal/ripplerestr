#' Get Server Status
#'
#' Retrieve information about the current status of the \code{ripple-rest} API
#' and the \code{rippled} server it is connected to.
#'
#' @return A list of lists
#'
#' @export
get_server_status <- function() {
    path <- "v1/server"
    req <- .GET(path)
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
#' @return \code{TRUE} or \code{FALSE}
#'
#' @export
is_server_connected <- function() {
    path <- "v1/server/connected"
    req <- .GET(path)
    .parse(req)$connected
}
