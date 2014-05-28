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

#' getDestinationBalanceChanges
#'
#' Extracts the \code{destination_balance_changes} slot.
#'
#' @return An object of class \code{"\link{Amount}"}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname getDestinationBalanceChanges-methods
setGeneric("getDestinationBalanceChanges",
           function(object, ...)
               standardGeneric("getDestinationBalanceChanges"))

#' hasLedger
#'
#' Checks whether an object has a valid \code{ledger} slot.
#'
#' @return \code{TRUE} or \code{FALSE}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname hasLedger-methods
setGeneric("hasLedger",
           function(object, ...)
               standardGeneric("hasLedger"))

#' setSourceTag
#'
#' Sets the \code{source_tag} slot.
#'
#' @return \code{object} with \code{source_tag} set to \code{tag}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param tag Object of class \code{"\link{UINT32}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname setSourceTag-methods
setGeneric("setSourceTag",
           function(object, tag, ...)
               standardGeneric("setSourceTag"))

#' setDestinationTag
#'
#' Sets the \code{destination_tag} slot.
#'
#' @return \code{object} with \code{destination_tag} set to \code{tag}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param tag Object of class \code{"\link{UINT32}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname setDestinationTag-methods
setGeneric("setDestinationTag",
           function(object, tag, ...)
               standardGeneric("setDestinationTag"))

#' setInvoiceId
#'
#' Sets the \code{invoice_id} slot.
#'
#' @return \code{object} with \code{invoice_id} set to \code{id}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param id Object of class \code{"\link{Hash256}"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname setInvoiceId-methods
setGeneric("setInvoiceId",
           function(object, id, ...)
               standardGeneric("setInvoiceId"))

#' setSourceSlippage
#'
#' Sets the \code{source_slippage} slot.
#'
#' @return \code{object} with \code{source_slippage} set to \code{x}.
#'
#' @param object Object of class \code{"\link{Payment}"}.
#' @param x Object of class \code{"numeric"}.
#' @param ... ignored
#'
#' @export
#' @docType methods
#' @rdname setSourceSlippage-methods
setGeneric("setSourceSlippage",
           function(object, x, ...)
               standardGeneric("setSourceSlippage"))
