#' Ripple REST Client for R
#'
#' \code{ripple-rest} is a RESTful API for submitting payments and monitoring
#' accounts on the Ripple Network.
#'
#' @references
#' \url{https://github.com/ripple/ripple-rest}
#'
#' @name ripplerestr
#' @docType package
#' @import httr
NULL

# Helper functions from httr vignette.
.GET <- function(path, ...) {
    req <- GET("http://localhost:5990/", path = path, ...)
    .check(req)
    .success(req)

    req
}

.success <- function(req) {
    if (.parse(req)$success)
        return(invisible())
    else
        stop(.parse(req)$message, call. = FALSE)
}

.check <- function(req) {
    if (req$status_code < 400)
        return(invisible())

    if (req$status_code == 404)
        stop("HTTP failure: 404\n", content(req, as = "text"), call. = FALSE)

    message <- .parse(req)$message
    stop("HTTP failure: ", req$status_code, "\n", message, call. = FALSE)
}

.parse <- function(req) {
    text <- content(req, as = "text")
    if (identical(text, ""))
        stop("No output to parse", call. = FALSE)
    jsonlite::fromJSON(text, simplifyVector = FALSE)
}
