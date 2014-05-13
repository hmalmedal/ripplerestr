setMethod("initialize",
          signature(.Object = "Amount"),
          function (.Object, value, currency,
                    issuer, counterparty)
          {
              if (nargs() == 1) return(.Object)

              if (missing(issuer))
                  issuer <- rep.int("", length(value))
              else if (length(issuer) == 1)
                  issuer <- rep.int(issuer, length(value))

              if (missing(counterparty))
                  counterparty <- rep.int("", length(value))
              else if (length(counterparty) == 1)
                  counterparty <- rep.int(counterparty, length(value))

              .Object@value <- as.numeric(value)
              .Object@currency <- Currency(currency)
              .Object@issuer <- as.character(issuer)
              .Object@counterparty <- as.character(counterparty)

              validObject(.Object)
              .Object
          }
)
