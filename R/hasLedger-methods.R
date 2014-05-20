#' @rdname hasLedger-methods
setMethod("hasLedger",
          signature(object = "Payment"),
          function(object)
          {
              ledger <- object@ledger
              if (length(ledger) == 0)
                  return(FALSE)
              if (is.na(ledger))
                  return(FALSE)
              TRUE
          }
)
