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


