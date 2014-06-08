#' Retrieve Ripple Transaction
#'
#' While the \code{ripple-rest} API is a high-level API built on top of the
#' \code{rippled} server, there are times when you may need to access an
#' underlying Ripple transaction rather than dealing with the \code{ripple-rest}
#' data format. When you need to do this, you can retrieve a transaction with
#' this function.
#'
#' @param hash Transaction hash
#'
#' @return A list
#'
#' @export
get_transaction <- function(hash) {
    hash <- Hash256(hash)
    assert_that(is.string(hash))

    path <- paste0("v1/tx/", hash)
    req <- .GET(path)
    .parse(req)$transaction
}
