#' Ripple REST Client for R
#'
#' @name ripplerestr
#' @docType package
#' @import httr
NULL

# Helper functions from httr vignette.
.GET <- function(path, ...) {
    req <- GET("http://localhost:5990/", path = path, ...)
    .check(req)
    
    req
}

.check <- function(req) {
    if (req$status_code < 400) 
        return(invisible())
    
    message <- content(req, as = "text")
    stop("HTTP failure: ", req$status_code, "\n  ", message, call. = FALSE)
}

.parse <- function(req) {
    text <- content(req, as = "text")
    if (identical(text, "")) 
        stop("No output to parse", call. = FALSE)
    jsonlite::fromJSON(text, simplifyVector = FALSE)
}
