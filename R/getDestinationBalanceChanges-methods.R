#' @rdname getDestinationBalanceChanges-methods
setMethod("getDestinationBalanceChanges",
          signature(object = "Payment"),
          function(object)
          {
              object@destination_balance_changes
          }
)
