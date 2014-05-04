#' Get server info
#'
#' Retrieve information about the \code{ripple-rest} and connected
#' \code{rippled}'s current status.
#'
#' @export
server_status <- function(...) {
    path <- "v1/server"
    .GET(path, ...)
}

#' Get connected state
#'
#' A simple endpoint that can be used to check if \code{ripple-rest} is
#' connected to a \code{rippled} and is ready to serve. If used before querying
#' the other endpoints this can be used to centralize the logic to handle if
#' \code{rippled} is disconnected from the Ripple Network and unable to process
#' transactions.
#'
#' @return TRUE or FALSE
#'
#' @export
server_connected <- function(...) {
    path <- "v1/server/connected"
    req <- .GET(path, ...)
    .parse(req)$connected
}

#' Get UUID
#'
#' A UUID v4 generator, which can be used if the client wishes to use UUIDs for
#' the \code{client_resource_id} but does not have a UUID generator handy.
#'
#' @export
uuid_generator <- function(...) {
    path <- "v1/uuid"
    .GET(path, ...)
}
