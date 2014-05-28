ripplerestr
===========

Use **R** with the [`ripple-rest`](https://dev.ripple.com/) API.

Introduction
------------

[Ripple](https://ripple.com/) is an Internet protocol for making financial transactions.

The [`ripple-rest`](https://dev.ripple.com/) API makes it easy to access the Ripple system via a RESTful web interface.

The **R** package [`ripplerestr`](https://github.com/hmalmedal/ripplerestr) uses the [`httr`](https://github.com/hadley/httr) library to communicate with `ripple-rest`.

Prerequisites
-------------

Before you can use the `ripple-rest` API, you will need to have three things:

 * An installed version of `ripple-rest` running locally or remotely. Instructions on installing `ripple-rest` can be found in the README.md file in the [Github repository](https://github.com/ripple/ripple-rest).
 * An activated Ripple account.
 * The URL of the server running the `ripple-rest` API that you wish to use.

Installation
------------

Download the [latest release](https://github.com/hmalmedal/ripplerestr/releases/latest) and install it.

You can alternatively install the current version from GitHub:


```r
if (!require("devtools")) install.packages("devtools")
require("devtools")
install_github("hmalmedal/ripplerestr")
```


Set up
------

Load the `ripplerestr` library and set the URL.


```r
library(ripplerestr)
options(ripplerestr.url = "http://localhost:5990/")
```




Check server
------------

Check whether the server is ready to be used.


```r
is_server_connected()
```

```
## [1] TRUE
```


Get an account's balances
-------------------------

Find how much USD Bitstamp has issued.


```r
bitstamp_coldwallet <- "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B"
bitstamp_hotwallet <- "rrpNnNLKrartuEqfJGpqyDwPj1AFPg9vn1"
bitstamp_coldUSD <- get_account_balances(bitstamp_coldwallet, "USD")
bitstamp_hotUSD <- get_account_balances(bitstamp_hotwallet, "USD")
bitstamp_USD <- sum(bitstamp_coldUSD) + sum(bitstamp_hotUSD)
bitstamp_USD
```

```
## [1] -1900765
```


Examine account settings
------------------------

Compare the transfer rates of different gateways.


```r
df <- rbind(c("bitstamp", "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B"), c("dividendrippler", 
    "rfYv1TXnwgDDK4WQNbFALykYuEBnrR4pDX"), c("justcoin", "rJHygWcTLVpSXkowott6kzgZU6viQSVYM1"))
colnames(df) <- c("gateway", "address")
df <- as.data.frame(df)
settings <- lapply(df$address, get_account_settings)
df$transfer_rate <- sapply(settings, getTransferRate)
print(df, digits = 5)
```

```
##           gateway                            address transfer_rate
## 1        bitstamp  rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B        1.0020
## 2 dividendrippler rfYv1TXnwgDDK4WQNbFALykYuEBnrR4pDX        1.0015
## 3        justcoin rJHygWcTLVpSXkowott6kzgZU6viQSVYM1        1.0000
```


Send a payment
--------------

Find possible payment paths.


```r
address <- "rJMNfiJTwXHcMdB4SpxMgL3mvV4xUVHDnd"
destination_account <- "rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X"
paths <- get_payment_paths(address, destination_account, value = 0.01, currency = "USD")
```


Examine the possible amounts that can be sent.


```r
source_amount(paths)
```

```
## An object of class "Amount"
## [1] "0.01+USD"
```


Select one path and set tags and id.


```r
payment <- paths[1]
source_tag(payment) <- 123
destination_tag(payment) <- 456
invoice_id(payment) <- "0000000000000000000000000000000000000000000000000000000000000000"
```


Generate an identifier and submit the payment to the network. It is probably best to read the secret from an encrypted file.


```r
secret <- "snQ9dAZHB3rvqcgRqjbyWHJDeVJbA"
uuid <- generate_uuid()
response <- submit_payment(payment, secret, uuid)
```


Check the status of the payment.


```r
repeat {
    status <- check_payment_status(response$status_url)
    if (has_ledger(status)) 
        break
    Sys.sleep(1)
}
```


Display how the amounts have changed.


```r
source_balance_changes(status)
```

```
## An object of class "Amount"
## [1] "-0.01+USD+rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X"
## [2] "-1.2e-05+XRP"
```

```r
destination_balance_changes(status)
```

```
## An object of class "Amount"
## [1] "0.01+USD+rH3WTUovV1HKx4S5HZup4dUZEjeGnehL6X"
```


