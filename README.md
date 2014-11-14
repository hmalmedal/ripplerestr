ripplerestr
===========

[![Build Status](https://travis-ci.org/hmalmedal/ripplerestr.png?branch=master)](https://travis-ci.org/hmalmedal/ripplerestr)

Use **R** with the [Ripple-REST](https://ripple.com/build/ripple-rest/) API.

Introduction
------------

[Ripple](https://ripple.com/) is an Internet protocol for making financial transactions.

The [Ripple-REST](https://ripple.com/build/ripple-rest/) API provides a simplified, easy-to-use interface to the Ripple Network via a RESTful API.

The **R** package [`ripplerestr`](https://github.com/hmalmedal/ripplerestr) uses the [`httr`](https://github.com/hadley/httr) package to communicate with Ripple-REST.

Prerequisites
-------------

Before you can use the Ripple-REST API, you will need to have three things:

 * An installed version of Ripple-REST running locally or remotely. Instructions on installing Ripple-REST can be found in the README.md file in the [Github repository](https://github.com/ripple/ripple-rest).
 * An activated Ripple account.
 * The URL of the server running the Ripple-REST API that you wish to use.

Installation
------------

Download the [latest release](https://github.com/hmalmedal/ripplerestr/releases/latest) and install it.

You can alternatively install the current version from GitHub:

``` {.r}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("hmalmedal/ripplerestr")
```

Set up
------

Load `ripplerestr` and set the URL.

``` {.r}
library(ripplerestr)
options("ripplerestr.url" = "http://localhost:5990/")
```
