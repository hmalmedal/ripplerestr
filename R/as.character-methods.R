setAs("Balance", "character",
      function(from) {
          value <- as.character(from@value)
          currency <- from@currency
          counterparty <- from@counterparty
          result <- paste(value, currency, counterparty, sep = "+")
          sub("\\+$", "", result)
      })
#' as.character for Balance class
#'
setMethod("as.character",
          signature(x = "Balance"),
          function (x, ...)
          {
              as(x, "character")
          }
)

setAs("Amount", "character",
      function(from) {
          issuer <- from@issuer
          if (all(issuer == ""))
              issuer <- from@counterparty
          value <- as.character(from@value)
          currency <- from@currency
          result <- paste(value, currency, issuer, sep = "+")
          sub("\\+$", "", result)
      })
#' as.character for Amount class
#'
setMethod("as.character",
          signature(x = "Amount"),
          function (x, ...)
          {
              as(x, "character")
          }
)