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

#' getSourceBalanceChanges
#'
#' Extracts the \code{source_balance_changes} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
setGeneric("getSourceBalanceChanges",
           function(object, ...)
               standardGeneric("getSourceBalanceChanges"))

#' getDestinationBalanceChanges
#'
#' Extracts the \code{destination_balance_changes} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
setGeneric("getDestinationBalanceChanges",
           function(object, ...)
               standardGeneric("getDestinationBalanceChanges"))

#' hasLedger
#'
#' Checks whether an object has a valid \code{ledger} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
setGeneric("hasLedger",
           function(object, ...)
               standardGeneric("hasLedger"))

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

#' setDestinationTag
#'
#' Sets the \code{destination_tag} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param tag Object of class \code{"\link{UINT32}"}.
#' @param ... ignored
#'
#' @export
setGeneric("setDestinationTag",
           function(object, tag, ...)
               standardGeneric("setDestinationTag"))

#' setInvoiceId
#'
#' Sets the \code{invoice_id} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param id Object of class \code{"\link{Hash256}"}.
#' @param ... ignored
#'
#' @export
setGeneric("setInvoiceId",
           function(object, id, ...)
               standardGeneric("setInvoiceId"))

#' setSourceSlippage
#'
#' Sets the \code{source_slippage} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"numeric"}.
#' @param ... ignored
#'
#' @export
setGeneric("setSourceSlippage",
           function(object, x, ...)
               standardGeneric("setSourceSlippage"))

#' setPartialPayment
#'
#' Sets the \code{partial_payment} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"logical"}.
#' @param ... ignored
#'
#' @export
setGeneric("setPartialPayment",
           function(object, x, ...)
               standardGeneric("setPartialPayment"))

#' setNoDirectRipple
#'
#' Sets the \code{no_direct_ripple} slot.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"logical"}.
#' @param ... ignored
#'
#' @export
setGeneric("setNoDirectRipple",
           function(object, x, ...)
               standardGeneric("setNoDirectRipple"))
