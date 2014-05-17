#' getTransferRate for AccountSettings class
#'
#' Extracts the \code{transfer_rate} slot.
#'
#' @param object Object of class \code{"\link{AccountSettings}"}.
#'
#' @export
setMethod("getTransferRate",
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
