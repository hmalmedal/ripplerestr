#' @rdname getTransferRate-methods
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
