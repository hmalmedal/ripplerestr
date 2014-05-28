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

#' getTransferRate
#'
#' Extracts the \code{transfer_rate} slot.
#'
#' @return The transfer rate as \code{"numeric"}.
#'
#' @param object Object of class \code{"\link{AccountSettings}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname getTransferRate-methods
setGeneric("getTransferRate",
           function(object, ...)
               standardGeneric("getTransferRate"))

#' getSourceAmount
#'
#' Extracts the \code{source_amount} slot.
#'
#' @return An object of class \code{"\link{Amount}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname getSourceAmount-methods
setGeneric("getSourceAmount",
           function(object, ...)
               standardGeneric("getSourceAmount"))

#' getSourceBalanceChanges
#'
#' Extracts the \code{source_balance_changes} slot.
#'
#' @return An object of class \code{"\link{Amount}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname getSourceBalanceChanges-methods
setGeneric("getSourceBalanceChanges",
           function(object, ...)
               standardGeneric("getSourceBalanceChanges"))
