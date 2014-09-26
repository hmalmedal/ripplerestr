#' Get Server Status
#'
#' Retrieve information about the current status of the Ripple-REST API and the
#' \code{rippled} server it is connected to.
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
