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
