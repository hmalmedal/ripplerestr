#' @include Amount-class.R Balance-class.R UINT32-class.R
setAs("Amount", "Balance",
      function(from) {
          issuer <- from@issuer
          if (all(issuer == ""))
              issuer <- from@counterparty
          value <- from@value
          currency <- from@currency
          Balance(value = value,
                  currency = currency,
                  counterparty = issuer)
      })
setAs("Balance", "Amount",
      function(from) {
          value <- from@value
          currency <- from@currency
          counterparty <- from@counterparty
          Amount(value = value,
                 currency = currency,
                 counterparty = counterparty)
      })
setAs("ANY", "UINT32", function(from) {
    from <- UINT32(as.numeric(from))
    validObject(from)
    from
})
