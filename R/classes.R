#' Currency
#'
#' The three-character code or hex string used to denote currencies
#'
#' @export Currency
#' @exportClass Currency
Currency <- setClass("Currency", contains = "character")
validCurrencyObject <- function(object) {
    if (length(object) != 1) {
        return(paste0("Length is ", length(object), ", should be 1."))
    }
    if (!grepl("^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$", object)) {
        return("Invalid currency.")
    }
    return(TRUE)
}
setValidity("Currency", validCurrencyObject)
