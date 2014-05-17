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
-----

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


List server information.


```r
get_server_status()
```

```
## $rippled_server_url
## [1] "wss://s-west.ripple.com:443"
## 
## $rippled_server_status
## $rippled_server_status$build_version
## [1] "0.25.1"
## 
## $rippled_server_status$complete_ledgers
## [1] "32570-6670810"
## 
## $rippled_server_status$hostid
## [1] "AIR"
## 
## $rippled_server_status$io_latency_ms
## [1] 1
## 
## $rippled_server_status$last_close
## $rippled_server_status$last_close$converge_time_s
## [1] 2.045
## 
## $rippled_server_status$last_close$proposers
## [1] 5
## 
## 
## $rippled_server_status$load_factor
## [1] 1
## 
## $rippled_server_status$peers
## [1] 6
## 
## $rippled_server_status$pubkey_node
## [1] "n9LVtEwRBRfLhrs5cZcKYiYMw6wT9MgmAZEMQEXmX4Bwkq4D6hc1"
## 
## $rippled_server_status$server_state
## [1] "full"
## 
## $rippled_server_status$validated_ledger
## $rippled_server_status$validated_ledger$age
## [1] 2
## 
## $rippled_server_status$validated_ledger$base_fee_xrp
## [1] 1e-05
## 
## $rippled_server_status$validated_ledger$hash
## [1] "409A8AE82EDAA555B787C5C4A8FD94DF8B2874FD8E30CCCD8C86BFF31390BB75"
## 
## $rippled_server_status$validated_ledger$reserve_base_xrp
## [1] 20
## 
## $rippled_server_status$validated_ledger$reserve_inc_xrp
## [1] 5
## 
## $rippled_server_status$validated_ledger$seq
## [1] 6670810
## 
## 
## $rippled_server_status$validation_quorum
## [1] 3
## 
## 
## $api_documentation_url
## [1] "https://github.com/ripple/ripple-rest"
```


