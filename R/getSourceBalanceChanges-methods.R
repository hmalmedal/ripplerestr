#' @rdname getSourceBalanceChanges-methods
setMethod("getSourceBalanceChanges",
          signature(object = "Payment"),
          function(object)
          {
              object@source_balance_changes
          }
)
