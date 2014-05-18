#' getCurrency
#'
#' Extracts the \code{currency} slot.
#'
#' @param object Object with currency slot.
#' @param ... ignored
#'
#' @export
setGeneric("getCurrency",
           function(object, ...)
               standardGeneric("getCurrency"))

#' getTransferRate
#'
#' Extracts the \code{transfer_rate} slot.
#'
#' @param object Object of class \code{"\link{AccountSettings}"}.
#' @param ... ignored
#'
#' @export
setGeneric("getTransferRate",
           function(object, ...)
               standardGeneric("getTransferRate"))

#' getSourceAmount
#'
#' Extracts the \code{source_amount} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
setGeneric("getSourceAmount",
           function(object, ...)
               standardGeneric("getSourceAmount"))

#' setSourceTag
#'
#' Sets the \code{source_tag} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param tag Object of class \code{"\link{UINT32}"}.
#' @param ... ignored
#'
#' @export
setGeneric("setSourceTag",
           function(object, tag, ...)
               standardGeneric("setSourceTag"))
