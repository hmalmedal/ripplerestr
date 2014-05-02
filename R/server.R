#' Get server info
#'
#' Retrieve information about the \code{ripple-rest} and connected
#' \code{rippled}'s current status.
#'
#' @export
server_status <- function(server = "http://localhost:5990") {
    endpoint <- "/v1/server"
    url  <- paste0(server, endpoint)
    return(content(GET(url)))
}
#' Get connected state
#'
#' A simple endpoint that can be used to check if \code{ripple-rest} is
#' connected to a \code{rippled} and is ready to serve. If used before querying
#' the other endpoints this can be used to centralize the logic to handle if
#' \code{rippled} is disconnected from the Ripple Network and unable to process
#' transactions.
#'
#' @export
server_connected <- function(server = "http://localhost:5990") {
    endpoint <- "/v1/server/connected"
    url  <- paste0(server, endpoint)
    return(content(GET(url)))
}
