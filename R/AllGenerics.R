#' getCurrency
#'
#' Extracts the \code{currency} slot.
#'
#' @param object Object with currency slot.
#' @param ... ignored
#'
#' @return An object of class \code{"\link{Currency}"}.
#'
#' @export
#' @docType methods
#' @rdname getCurrency-methods
setGeneric("getCurrency",
           function(object, ...)
               standardGeneric("getCurrency"))
