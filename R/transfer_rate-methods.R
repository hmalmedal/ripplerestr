#' Get \code{transfer_rate} value
#'
#' Access the \code{transfer_rate} slot.
#'
#' @return The transfer rate as \code{"numeric"}.
#'
#' @param object Object of class \code{"\link{AccountSettings}"}.
#'
#' @export transfer_rate
#' @docType methods
#' @rdname transfer_rate-methods
#' @include AccountSettings-class.R
setGeneric("transfer_rate",
           function(object)
               standardGeneric("transfer_rate"))

#' @rdname transfer_rate-methods
setMethod("transfer_rate",
          signature(object = "AccountSettings"),
          function(object)
          {
              rate <- object@transfer_rate
              if (is.na(rate) | rate == 0)
                  1
              else
                  rate / 1e9
          }
)
