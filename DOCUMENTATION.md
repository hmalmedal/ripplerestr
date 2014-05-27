  ----------------------- -----------------
  AccountSettings-class   R Documentation
  ----------------------- -----------------

AccountSettings
---------------

### Description

The return value from `change_account_settings` and
`get_account_settings`.

### Details

Each slot length must be `0` or `1`.

### Slots

`account`
  ~ Object of class `"RippleAddress"`. The Ripple address of the account
    in question.

`regular_key`
  ~ Object of class `"RippleAddress"`. The hash of an optional
    additional public key that can be used for signing and verifying
    transactions.

`domain`
  ~ Object of class `"character"`. The domain associated with this
    account. The `ripple.txt` file can be looked up to verify this
    information.

`email_hash`
  ~ Object of class `"Hash128"`. The MD5 128-bit hash of the account
    owner's email address.

`message_key`
  ~ Object of class `"character"`. An optional public key, represented
    as hex, that can be set to allow others to send encrypted messages
    to the account owner.

`transfer_rate`
  ~ Object of class `"UINT32"`.

`require_destination_tag`
  ~ Object of class `"logical"`. If set to `TRUE` incoming payments will
    only be validated if they include a `destination_tag`. This may be
    used primarily by gateways that operate exclusively with hosted
    wallets.

`require_authorization`
  ~ Object of class `"logical"`. If set to `TRUE` incoming trustlines
    will only be validated if this account first creates a trustline to
    the counterparty with the authorized flag set to `TRUE`. This may be
    used by gateways to prevent accounts unknown to them from holding
    currencies they issue.

`disallow_xrp`
  ~ Object of class `"logical"`. If set to `TRUE` incoming XRP payments
    will not be allowed.

`password_spent`
  ~ Object of class `"logical"`.

`disable_master`
  ~ Object of class `"logical"`.

`transaction_sequence`
  ~ Object of class `"UINT32"`. The last sequence number of a validated
    transaction created by this account.

`trustline_count`
  ~ Object of class `"UINT32"`. The number of trustlines owned by this
    account. This value does not include incoming trustlines where this
    account has not explicitly reciprocated trust.

`ledger`
  ~ Object of class `"numeric"`. The index number of the ledger
    containing these account settings or, in the case of historical
    queries, of the transaction that modified these settings.

`hash`
  ~ Object of class `"Hash256"`. If this object was returned by a
    historical query this value will be the hash of the transaction that
    modified these settings. The transaction hash is used throughout the
    Ripple Protocol to uniquely identify a particular transaction.


  -------------- -----------------
  Amount-class   R Documentation
  -------------- -----------------

Amount
------

### Description

An Amount on the Ripple Protocol, used also for XRP in the ripple-rest
API.

### Details

Each element of the slots `issuer` and `counterparty` must match the
regular expression `"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"`.

All slot lengths must be equal.

### Slots

`value`
  ~ Object of class `"numeric"`. The quantity of the currency.

`currency`
  ~ Object of class `"Currency"`. The currency expressed as a
    three-character code.

`issuer`
  ~ Object of class `"character"`. The Ripple account address of the
    currency's issuer or gateway, or an empty string if the currency is
    XRP.

`counterparty`
  ~ Object of class `"character"`. The Ripple account address of the
    currency's issuer or gateway, or an empty string if the currency is
    XRP.


  ---------------------------- -----------------
  as.character,Amount-method   R Documentation
  ---------------------------- -----------------

as.character for Amount class
-----------------------------

### Description

as.character for Amount class

### Usage

    ## S4 method for signature 'Amount'
    as.character(x, ...)

### Arguments

`x`

object to be coerced or tested.

`...`

further arguments passed to or from other methods.
  ----------------------------- -----------------
  as.character,Balance-method   R Documentation
  ----------------------------- -----------------

as.character for Balance class
------------------------------

### Description

as.character for Balance class

### Usage

    ## S4 method for signature 'Balance'
    as.character(x, ...)

### Arguments

`x`

object to be coerced or tested.

`...`

further arguments passed to or from other methods.
  -------------------------- -----------------
  as.numeric,Amount-method   R Documentation
  -------------------------- -----------------

as.numeric for Amount class
---------------------------

### Description

Extracts the slot `"value"` from an `Amount` object

### Usage

    ## S4 method for signature 'Amount'
    as.numeric(x, ...)

### Arguments

`x`

object to be coerced or tested.

`...`

further arguments passed to or from other methods.
  --------------------------- -----------------
  as.numeric,Balance-method   R Documentation
  --------------------------- -----------------

as.numeric for Balance class
----------------------------

### Description

Extracts the slot `"value"` from a `Balance` object

### Usage

    ## S4 method for signature 'Balance'
    as.numeric(x, ...)

### Arguments

`x`

object to be coerced or tested.

`...`

further arguments passed to or from other methods.
  --------------- -----------------
  Balance-class   R Documentation
  --------------- -----------------

Balance
-------

### Description

A simplified representation of an account Balance.

### Details

Each element of the slot `counterparty` must match the regular
expression `"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"`.

All slot lengths must be equal.

### Slots

`value`
  ~ Object of class `"numeric"`. The quantity of the currency.

`currency`
  ~ Object of class `"Currency"`. The currency expressed as a
    three-character code.

`counterparty`
  ~ Object of class `"character"`. The Ripple account address of the
    currency's issuer or gateway, or an empty string if the currency is
    XRP.


  ------------------ -----------------
  c,Balance-method   R Documentation
  ------------------ -----------------

Combine for Balance class
-------------------------

### Description

Combine for Balance class

### Usage

    ## S4 method for signature 'Balance'
    c(x, ..., recursive = FALSE)

### Arguments

`x`

object to be concatenated.

`recursive`

ignored

`...`

objects to be concatenated.
  --------------------------- -----------------
  change\_account\_settings   R Documentation
  --------------------------- -----------------

Updating Account Settings
-------------------------

### Description

Change an account's settings

### Usage

    change_account_settings(address, secret, transfer_rate, domain, message_key,
      email_hash, disallow_xrp = NA, require_authorization = NA,
      require_destination_tag = NA, password_spent = NA)

### Arguments

`address`

The Ripple address of the desired account.

`secret`

The secret key for your Ripple account.

`transfer_rate`

The rate charged each time a holder of currency issued by this account
transfers some funds. The default and minimum rate is "1.0"; a rate of
"1.01" is a 1% charge on top of the amount being transferred. Up to nine
decimal places are supported.

`domain`

The domain name associated with this account.

`message_key`

An optional public key, represented as a hex string, that can be used to
allow others to send encrypted messages to the account owner.

`email_hash`

The MD5 128-bit hash of the account owner's email address, if known.

`disallow_xrp`

If this is set to `TRUE`, payments in XRP will not be allowed.

`require_authorization`

If this is set to `TRUE`, incoming trustlines will only be validated if
this account first creates a trustline to the counterparty with the
authorized flag set to `TRUE`. This may be used by gateways to prevent
accounts unknown to them from holding currencies they issue.

`require_destination_tag`

If this is set to `TRUE`, incoming payments will only be validated if
they include a `destination_tag` value. Note that this is used primarily
by gateways that operate exclusively with hosted wallets.

`password_spent`

`TRUE` if the password has been "spent", else `FALSE`.

### Value

An object of class `"AccountSettings"`
  ------------------------ -----------------
  check\_payment\_status   R Documentation
  ------------------------ -----------------

Confirming a Payment
--------------------

### Description

To confirm that your payment has been submitted successfully, you can
call this.

### Usage

    check_payment_status(status_url, address, client_resource_id, hash)

### Arguments

`status_url`

Return value from `submit_payment`.

`address`

The Ripple address for the source account. Ignored if `status_url` is
provided.

`client_resource_id`

Provided to `submit_payment`. Ignored if `status_url` is provided.

`hash`

The transaction hash for the desired payment. Ignored if `status_url` or
`client_resource_id` is provided.

### Value

An object of class `"Payment"`
  ---------------- -----------------
  Currency-class   R Documentation
  ---------------- -----------------

Currency
--------

### Description

The three-character code or hex string used to denote currencies.

### Details

A character vector where each element must match the regular expression
`"^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$"`.

### Examples

    USD <- Currency("USD")
    XAU <- Currency("015841551A748AD2C1F76FF6ECB0CCCD00000000")
  ---------------- -----------------
  generate\_uuid   R Documentation
  ---------------- -----------------

Create Client Resource ID
-------------------------

### Description

This endpoint creates a universally unique identifier (UUID) value which
can be used to calculate a client resource ID for a payment. This can be
useful if the application does not have a UUID generator handy.

### Usage

    generate_uuid()

### Value

An object of class `"ResourceId"`
  ------------------------ -----------------
  get\_account\_balances   R Documentation
  ------------------------ -----------------

Account Balances
----------------

### Description

Retrieve the current balances for the given Ripple account.

### Usage

    get_account_balances(address, currency, counterparty)

### Arguments

`address`

The Ripple address of the desired account

`currency`

Three letter currency denominations

`counterparty`

The Ripple address of the counterparty trusted

### Details

The parameters `currency` and `counterparty` are supported to provide
additional filtering.

### Value

An object of class `"Balance"`

### Examples

    root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
    ## Not run: 
    get_account_balances(root_account)
    ## End(Not run)
  ------------------------ -----------------
  get\_account\_payments   R Documentation
  ------------------------ -----------------

Payment History
---------------

### Description

This API endpoint can be used to browse through an account's payment
history and also used to confirm specific payments after a payment has
been submitted.

### Usage

    get_account_payments(address, source_account, destination_account,
      exclude_failed = FALSE, direction, earliest_first = FALSE, start_ledger,
      end_ledger, results_per_page = 10, page = 1)

### Arguments

`address`

The Ripple address of the desired account

`source_account`

Filter the results to only include payments sent by the given account.

`destination_account`

Filter the results to only include payments received by the given
account.

`exclude_failed`

If set to `TRUE`, the results will only include payments which were
successfully validated and written into the ledger. Otherwise, failed
payments will be included. Defaults to `FALSE`.

`direction`

Limit the results to only include the given type of payments. The
following direction values are currently supported: `incoming`,
`outgoing`, `pending`

`earliest_first`

If set to `TRUE`, the payments will be returned in ascending date order.
Otherwise, the payments will be returned in descending date order (ie,
the most recent payment will be returned first). Defaults to `FALSE`.

`start_ledger`

The index for the starting ledger. If `earliest_first` is `TRUE`, this
will be the oldest ledger to be queried; otherwise, it will be the most
recent ledger. Defaults to the first ledger in the `rippled` server's
database.

`end_ledger`

The index for the ending ledger. If `earliest_first` is `TRUE`, this
will be the most recent ledger to be queried; otherwise, it will be the
oldest ledger. Defaults to the most recent ledger in the `rippled`
server's database.

`results_per_page`

The maximum number of payments to be returned at once. Defaults to 10.

`page`

The page number to be returned. The first page of results will have page
number 1, the second page will have page number 2, and so on. Defaults
to 1.

### Details

If the server returns fewer than `results_per_page` payments, then there
are no more pages of results to be returned. Otherwise, increment the
page number and re-issue the query to get the next page of results.

Note that the `ripple-rest` API has to retrieve the full list of
payments from the server and then filter them before returning them back
to the caller. This means that there is no speed advantage to specifying
more filter values.

### Value

A list of objects of class `"Payment"`
  ------------------------ -----------------
  get\_account\_settings   R Documentation
  ------------------------ -----------------

Account Settings
----------------

### Description

You can retrieve an account's settings. The server will return a list of
the current settings in force for the given account.

### Usage

    get_account_settings(address)

### Arguments

`address`

The Ripple address of the desired account

### Value

An object of class `"AccountSettings"`
  -------------------------- -----------------
  get\_account\_trustlines   R Documentation
  -------------------------- -----------------

Reviewing Trustlines
--------------------

### Description

Retrieves all trustlines associated with the Ripple address.

### Usage

    get_account_trustlines(address, currency, counterparty)

### Arguments

`address`

The Ripple address of the desired account

`currency`

Three letter currency denominations

`counterparty`

The Ripple address of the counterparty trusted

### Details

The parameters `currency` and `counterparty` are supported to provide
additional filtering.

### Value

An object of class `"Trustline"`
  ------------- -----------------
  getCurrency   R Documentation
  ------------- -----------------

getCurrency
-----------

### Description

Extracts the `currency` slot.

### Usage

    getCurrency(object, ...)

    ## S4 method for signature 'Balance'
    getCurrency(object)

    ## S4 method for signature 'Amount'
    getCurrency(object)

    ## S4 method for signature 'Trustline'
    getCurrency(object)

### Arguments

`object`

Object with currency slot.

`...`

ignored

### Value

An object of class `"Currency"`.
  ------------------------------ -----------------
  getDestinationBalanceChanges   R Documentation
  ------------------------------ -----------------

getDestinationBalanceChanges
----------------------------

### Description

Extracts the `destination_balance_changes` slot.

### Usage

    getDestinationBalanceChanges(object, ...)

    ## S4 method for signature 'Payment'
    getDestinationBalanceChanges(object)

### Arguments

`object`

Object of class `"Payment"`.

`...`

ignored

### Value

An object of class `"Amount"`.
  ------------------- -----------------
  get\_notification   R Documentation
  ------------------- -----------------

Checking Notifications
----------------------

### Description

This endpoint will grab the notification based on the specific
transaction hash specified. Once called the notification object
retrieved will provide information on the type of transaction and also
the previous and next notifications will be shown as well. The
`previous_notification_url` and `next_notification_url` can be used to
walk up and down the notification queue. Once the
`next_notification_url` is empty that means you have the most current
notification, this applies for the `previous_notification_url` similarly
when it's empty as it means you are holding the earliest notification
available on the rippled you are connecting to.

### Usage

    get_notification(address, hash)

### Arguments

`address`

The Ripple address of the desired account

`hash`

Transaction hash

### Value

An object of class `"Notification"`
  --------------------- -----------------
  get\_payment\_paths   R Documentation
  --------------------- -----------------

Preparing a Payment
-------------------

### Description

To prepare a payment, you first make a call to this endpoint. This will
generate a list of possible payments between the two parties for the
desired amount, taking into account the established trustlines between
the two parties for the currency being transferred. You can then choose
one of the returned payments, modify it if necessary (for example, to
set slippage values or tags), and then submit the payment for
processing.

### Usage

    get_payment_paths(address, destination_account, destination_amount, value,
      currency, issuer = "", source_currencies)

### Arguments

`address`

The Ripple address for the source account.

`destination_account`

The Ripple address for the destination account.

`destination_amount`

An object of class `"Amount"`. The amount to be sent to the destination
account.

`value`

The quantity of the currency. Ignored if `destination_amount` is
provided.

`currency`

The currency expressed as a three-character code. Ignored if
`destination_amount` is provided.

`issuer`

The Ripple account address of the currency's issuer or gateway, or an
empty string if the currency is XRP. Ignored if `destination_amount` is
provided.

`source_currencies`

A string or an object of class `"Amount"`. This is used to filter the
returned list of possible payments. Each source currency can be
specified either as a currency code, or as a currency code and issuer.
If the issuer is not specified for a currency other than XRP, then the
results will be limited to the specified currency, but any issuer for
that currency will be included in the results. The string should be a
comma-separated list of source currencies. Each source currency can be
specified either as a currency code (eg, `USD`), or as a currency code
and issuer (eg, `USD+r...`).

### Value

An object of class `"Payment"`
  --------------------- -----------------
  get\_server\_status   R Documentation
  --------------------- -----------------

Get Server Status
-----------------

### Description

Retrieve information about the current status of the `ripple-rest` API
and the `rippled` server it is connected to.

### Usage

    get_server_status()

### Value

A list of lists
  ----------------- -----------------
  getSourceAmount   R Documentation
  ----------------- -----------------

getSourceAmount
---------------

### Description

Extracts the `source_amount` slot.

### Usage

    getSourceAmount(object, ...)

    ## S4 method for signature 'Payment'
    getSourceAmount(object)

### Arguments

`object`

Object of class `"Payment"`.

`...`

ignored

### Value

An object of class `"Amount"`.
  ------------------------- -----------------
  getSourceBalanceChanges   R Documentation
  ------------------------- -----------------

getSourceBalanceChanges
-----------------------

### Description

Extracts the `source_balance_changes` slot.

### Usage

    getSourceBalanceChanges(object, ...)

    ## S4 method for signature 'Payment'
    getSourceBalanceChanges(object)

### Arguments

`object`

Object of class `"Payment"`.

`...`

ignored

### Value

An object of class `"Amount"`.
  ------------------ -----------------
  get\_transaction   R Documentation
  ------------------ -----------------

Retrieve Ripple Transaction
---------------------------

### Description

While the `ripple-rest` API is a high-level API built on top of the
`rippled` server, there are times when you may need to access an
underlying Ripple transaction rather than dealing with the `ripple-rest`
data format. When you need to do this, you can retrieve a transaction.

### Usage

    get_transaction(hash)

### Arguments

`hash`

Transaction hash

### Value

A list
  ----------------- -----------------
  getTransferRate   R Documentation
  ----------------- -----------------

getTransferRate
---------------

### Description

Extracts the `transfer_rate` slot.

### Usage

    getTransferRate(object, ...)

    ## S4 method for signature 'AccountSettings'
    getTransferRate(object)

### Arguments

`object`

Object of class `"AccountSettings"`.

`...`

ignored

### Value

The transfer rate as `"numeric"`.
  --------------- -----------------
  Hash128-class   R Documentation
  --------------- -----------------

Hash128
-------

### Description

The hex representation of a 128-bit hash.

### Details

A character vector where each element must match the regular expression
`"^$|^[A-Fa-f0-9]{32}$"`.
  --------------- -----------------
  Hash256-class   R Documentation
  --------------- -----------------

Hash256
-------

### Description

The hex representation of a 256-bit hash.

### Details

A character vector where each element must match the regular expression
`"^$|^[A-Fa-f0-9]{64}$"`.
  ----------- -----------------
  hasLedger   R Documentation
  ----------- -----------------

hasLedger
---------

### Description

Checks whether an object has a valid `ledger` slot.

### Usage

    hasLedger(object, ...)

    ## S4 method for signature 'Payment'
    hasLedger(object)

### Arguments

`object`

Object of class `"Payment"`.

`...`

ignored

### Value

`TRUE` or `FALSE`.
  ----------------------- -----------------
  is\_server\_connected   R Documentation
  ----------------------- -----------------

Check Connection State
----------------------

### Description

Checks to see if the `ripple-rest` API is currently connected to a
`rippled` server, and is ready to be used. This provides a quick and
easy way to check to see if the API is up and running, before attempting
to process transactions.

### Usage

    is_server_connected()

### Value

`TRUE` or `FALSE`
  ---------------------- -----------------
  length,Amount-method   R Documentation
  ---------------------- -----------------

Length for Amount class
-----------------------

### Description

Length for Amount class

### Usage

    ## S4 method for signature 'Amount'
    length(x)

### Arguments

`x`

an **R** object. For replacement, a vector or factor.
  ----------------------- -----------------
  length,Balance-method   R Documentation
  ----------------------- -----------------

Length for Balance class
------------------------

### Description

Length for Balance class

### Usage

    ## S4 method for signature 'Balance'
    length(x)

### Arguments

`x`

an **R** object. For replacement, a vector or factor.
  ---------------------------- -----------------
  length,Notification-method   R Documentation
  ---------------------------- -----------------

Length for Notification class
-----------------------------

### Description

Length for Notification class

### Usage

    ## S4 method for signature 'Notification'
    length(x)

### Arguments

`x`

an **R** object. For replacement, a vector or factor.
  ----------------------- -----------------
  length,Payment-method   R Documentation
  ----------------------- -----------------

Length for Payment class
------------------------

### Description

Length for Payment class

### Usage

    ## S4 method for signature 'Payment'
    length(x)

### Arguments

`x`

an **R** object. For replacement, a vector or factor.
  ------------------------- -----------------
  length,Trustline-method   R Documentation
  ------------------------- -----------------

Length for Trustline class
--------------------------

### Description

Length for Trustline class

### Usage

    ## S4 method for signature 'Trustline'
    length(x)

### Arguments

`x`

an **R** object. For replacement, a vector or factor.
  -------------------- -----------------
  Notification-class   R Documentation
  -------------------- -----------------

Notification
------------

### Description

The return value from `get_notification`.

### Details

All slot lengths must be equal.

### Slots

`account`
  ~ Object of class `"RippleAddress"`. The Ripple address of the account
    to which the notification pertains.

`type`
  ~ Object of class `"character"`. The resource type this notification
    corresponds to. Possible values are `"payment"`, `"order"`,
    `"trustline"`, `"accountsettings"`.

`direction`
  ~ Object of class `"character"`. The direction of the transaction,
    from the perspective of the account being queried. Possible values
    are `"incoming"`, `"outgoing"`, and `"passthrough"`.

`state`
  ~ Object of class `"character"`. The state of the transaction from the
    perspective of the Ripple Ledger. Possible values are `"validated"`
    and `"failed"`.

`result`
  ~ Object of class `"character"`. The rippled code indicating the
    success or failure type of the transaction. The code `"tesSUCCESS"`
    indicates that the transaction was successfully validated and
    written into the Ripple Ledger. All other codes will begin with the
    following prefixes: `"tec"`, `"tef"`, `"tel"`, or `"tej"`.

`ledger`
  ~ Object of class `"numeric"`. The index number of the ledger
    containing the validated or failed transaction. Failed payments will
    only be written into the Ripple Ledger if they fail after submission
    to a rippled and a Ripple Network fee is claimed.

`hash`
  ~ Object of class `"Hash256"`. The 256-bit hash of the transaction.
    This is used throughout the Ripple protocol as the unique identifier
    for the transaction.

`timestamp`
  ~ Object of class `"POSIXct"`. The timestamp representing when the
    transaction was validated and written into the Ripple ledger.

`transaction_url`
  ~ Object of class `"character"`. An URL that can be used to fetch the
    full resource this notification corresponds to.

`previous_notification_url`
  ~ Object of class `"character"`. An URL that can be used to fetch the
    notification that preceded this one chronologically.

`next_notification_url`
  ~ Object of class `"character"`. An URL that can be used to fetch the
    notification that followed this one chronologically.


  --------------- -----------------
  Payment-class   R Documentation
  --------------- -----------------

Payment class
-------------

### Description

A flattened Payment object used by the ripple-rest API.

### Details

All of the 11 first slot lengths must be equal.

Each of the other slot lengths must be `0` or `1`.

All elements of `source_slippage` must be greater than or equal to `0`.

The slots `partial_payment` and `no_direct_ripple` cannot contain `NA`.

### Slots

`source_account`
  ~ Object of class `"RippleAddress"`. The Ripple account address of the
    Payment sender.

`source_tag`
  ~ Object of class `"UINT32"`. An unsigned 32-bit integer most commonly
    used to refer to a sender's hosted account at a Ripple gateway.

`source_amount`
  ~ Object of class `"Amount"`. An optional amount that can be specified
    to constrain cross-currency payments.

`source_slippage`
  ~ Object of class `"numeric"`. An optional cushion for the
    `source_amount` to increase the likelihood that the payment will
    succeed. The `source_account` will never be charged more than
    `source_amount@value` + `source_slippage`.

`destination_account`
  ~ Object of class `"RippleAddress"`.

`destination_tag`
  ~ Object of class `"UINT32"`. An unsigned 32-bit integer most commonly
    used to refer to a receiver's hosted account at a Ripple gateway.

`destination_amount`
  ~ Object of class `"Amount"`. The amount the `destination_account`
    will receive.

`invoice_id`
  ~ Object of class `"Hash256"`. A 256-bit hash that can be used to
    identify a particular payment.

`paths`
  ~ Object of class `"character"`. A "stringified" version of the Ripple
    PathSet structure that users should treat as opaque.

`partial_payment`
  ~ Object of class `"logical"`. A boolean that, if set to `TRUE`,
    indicates that this payment should go through even if the whole
    amount cannot be delivered because of a lack of liquidity or funds
    in the `source_account` account.

`no_direct_ripple`
  ~ Object of class `"logical"`. A boolean that can be set to `TRUE` if
    paths are specified and the sender would like the Ripple Network to
    disregard any direct paths from the `source_account` to the
    `destination_account`. This may be used to take advantage of an
    arbitrage opportunity or by gateways wishing to issue balances from
    a hot wallet to a user who has mistakenly set a trustline directly
    to the hot wallet.

`direction`
  ~ Object of class `"character"`. The direction of the payment, from
    the perspective of the account being queried. Possible values are
    `"incoming"`, `"outgoing"`, and `"passthrough"`.

`state`
  ~ Object of class `"character"`. The state of the payment from the
    perspective of the Ripple Ledger. Possible values are `"validated"`
    and `"failed"` and `"new"` if the payment has not been submitted
    yet.

`result`
  ~ Object of class `"character"`. The rippled code indicating the
    success or failure type of the payment. The code `"tesSUCCESS"`
    indicates that the payment was successfully validated and written
    into the Ripple Ledger. All other codes will begin with the
    following prefixes: `"tec"`, `"tef"`, `"tel"`, or `"tej"`.

`ledger`
  ~ Object of class `"numeric"`. The index number of the ledger
    containing the validated or failed payment. Failed payments will
    only be written into the Ripple Ledger if they fail after submission
    to a rippled and a Ripple Network fee is claimed.

`hash`
  ~ Object of class `"Hash256"`. The 256-bit hash of the payment. This
    is used throughout the Ripple protocol as the unique identifier for
    the transaction.

`timestamp`
  ~ Object of class `"POSIXct"`. The timestamp representing when the
    payment was validated and written into the Ripple ledger.

`fee`
  ~ Object of class `"numeric"`. The Ripple Network transaction fee,
    represented in whole XRP (NOT "drops", or millionths of an XRP,
    which is used elsewhere in the Ripple protocol).

`source_balance_changes`
  ~ Object of class `"Amount"`. Parsed from the validated transaction
    metadata, this represents all of the changes to balances held by the
    `source_account`. Most often this will have one amount representing
    the Ripple Network fee and, if the `source_amount` was not XRP, one
    amount representing the actual `source_amount` that was sent.

`destination_balance_changes`
  ~ Object of class `"Amount"`. Parsed from the validated transaction
    metadata, this represents the changes to balances held by the
    `destination_account`. For those receiving payments this is
    important to check because if the `partial_payment` flag is set this
    value may be less than the `destination_amount`.


  ------------------ -----------------
  ResourceId-class   R Documentation
  ------------------ -----------------

ResourceId
----------

### Description

A client-supplied unique identifier (ideally a UUID) for this
transaction used to prevent duplicate payments and help confirm the
transaction's final status. All ASCII printable characters are allowed.
Note that 256-bit hex strings are disallowed because of the potential
confusion with transaction hashes.

### Details

A character vector where each element must match the regular expression
`"^(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$"`.
  --------------------- -----------------
  RippleAddress-class   R Documentation
  --------------------- -----------------

RippleAddress
-------------

### Description

A Ripple account address.

### Details

A character vector where each element must match the regular expression
`"^r[1-9A-HJ-NP-Za-km-z]{25,33}$"`.

### Examples

    root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
  ------------- -----------------
  ripplerestr   R Documentation
  ------------- -----------------

Ripple REST Client for R
------------------------

### Description

The `ripple-rest` API makes it easy to access the Ripple system via a
RESTful web interface.

### Details

The default url is `http://localhost:5990/`. You can change it by
setting the option `"ripplerestr.url"`.

### References

[https://dev.ripple.com/](https://dev.ripple.com/)

### Examples

    options("ripplerestr.url" = "http://example.com/")
  ------------------------- -----------------
  set\_account\_trustline   R Documentation
  ------------------------- -----------------

Granting a Trustline
--------------------

### Description

A trustline can also updated and simply set with a currency, amount,
counterparty combination by submitting to this endpoint.

### Usage

    set_account_trustline(address, secret, amount, allows_rippling = NA, limit,
      currency, counterparty)

### Arguments

`address`

The Ripple address of the desired account

`secret`

The secret key for your Ripple account.

`amount`

Object of class `"Amount"`. The limit, currency and counterparty for the
trustline.

`allows_rippling`

`TRUE` or `FALSE`. Allow rippling or not for the trustline.

`limit`

A number indicating the maximum you are willing to trust. Ignored if
`amount` is provided.

`currency`

Three letter currency denomination. Ignored if `amount` is provided.

`counterparty`

Ripple address of the counterparty trusted. Ignored if `amount` is
provided.

### Value

An object of class `"Trustline"`
  ------------------- -----------------
  setDestinationTag   R Documentation
  ------------------- -----------------

setDestinationTag
-----------------

### Description

Sets the `destination_tag` slot.

### Usage

    setDestinationTag(object, tag, ...)

    ## S4 method for signature 'Payment'
    setDestinationTag(object, tag)

### Arguments

`object`

Object of class `"Payment"`.

`tag`

Object of class `"UINT32"`.

`...`

ignored

### Value

`object` with `destination_tag` set to `tag`.
  -------------- -----------------
  setInvoiceId   R Documentation
  -------------- -----------------

setInvoiceId
------------

### Description

Sets the `invoice_id` slot.

### Usage

    setInvoiceId(object, id, ...)

    ## S4 method for signature 'Payment'
    setInvoiceId(object, id)

### Arguments

`object`

Object of class `"Payment"`.

`id`

Object of class `"Hash256"`.

`...`

ignored

### Value

`object` with `invoice_id` set to `id`.
  ------------------- -----------------
  setNoDirectRipple   R Documentation
  ------------------- -----------------

setNoDirectRipple
-----------------

### Description

Sets the `no_direct_ripple` slot.

### Usage

    setNoDirectRipple(object, x, ...)

    ## S4 method for signature 'Payment'
    setNoDirectRipple(object, x)

### Arguments

`object`

Object of class `"Payment"`.

`x`

Object of class `"logical"`.

`...`

ignored

### Value

`object` with `no_direct_ripple` set to `x`.
  ------------------- -----------------
  setPartialPayment   R Documentation
  ------------------- -----------------

setPartialPayment
-----------------

### Description

Sets the `partial_payment` slot.

### Usage

    setPartialPayment(object, x, ...)

    ## S4 method for signature 'Payment'
    setPartialPayment(object, x)

### Arguments

`object`

Object of class `"Payment"`.

`x`

Object of class `"logical"`.

`...`

ignored

### Value

`object` with `partial_payment` set to `x`.
  ------------------- -----------------
  setSourceSlippage   R Documentation
  ------------------- -----------------

setSourceSlippage
-----------------

### Description

Sets the `source_slippage` slot.

### Usage

    setSourceSlippage(object, x, ...)

    ## S4 method for signature 'Payment'
    setSourceSlippage(object, x)

### Arguments

`object`

Object of class `"Payment"`.

`x`

Object of class `"numeric"`.

`...`

ignored

### Value

`object` with `source_slippage` set to `x`.
  -------------- -----------------
  setSourceTag   R Documentation
  -------------- -----------------

setSourceTag
------------

### Description

Sets the `source_tag` slot.

### Usage

    setSourceTag(object, tag, ...)

    ## S4 method for signature 'Payment'
    setSourceTag(object, tag)

### Arguments

`object`

Object of class `"Payment"`.

`tag`

Object of class `"UINT32"`.

`...`

ignored

### Value

`object` with `source_tag` set to `tag`.
  ----------------------------- -----------------
  show,AccountSettings-method   R Documentation
  ----------------------------- -----------------

Show for AccountSettings class
------------------------------

### Description

Show for AccountSettings class

### Usage

    ## S4 method for signature 'AccountSettings'
    show(object)

### Arguments

`object`

Any R object
  -------------------- -----------------
  show,Amount-method   R Documentation
  -------------------- -----------------

Show for Amount class
---------------------

### Description

Show for Amount class

### Usage

    ## S4 method for signature 'Amount'
    show(object)

### Arguments

`object`

Any R object
  --------------------- -----------------
  show,Balance-method   R Documentation
  --------------------- -----------------

Show for Balance class
----------------------

### Description

Show for Balance class

### Usage

    ## S4 method for signature 'Balance'
    show(object)

### Arguments

`object`

Any R object
  ----------------- -----------------
  [,Amount-method   R Documentation
  ----------------- -----------------

Extract for Amount class
------------------------

### Description

Extract for Amount class

### Usage

    ## S4 method for signature 'Amount'
    x[i, j, ..., drop = TRUE]

### Arguments

`j`

ignored

`...`

ignored

`x`

object from which to extract element(s) or in which to replace
element(s).

`i`

indices specifying elements to extract or replace. Indices are `numeric`
or `character` vectors or empty (missing) or `NULL`. Numeric values are
coerced to integer as by `as.integer` (and hence truncated towards
zero). Character vectors will be matched to the `names` of the object
(or for matrices/arrays, the `dimnames`): see ‘Character indices’ below
for further details.

For `[`-indexing only: `i`, `j`, `...` can be logical vectors,
indicating elements/slices to select. Such vectors are recycled if
necessary to match the corresponding extent. `i`, `j`, `...` can also be
negative integers, indicating elements/slices to leave out of the
selection.

When indexing arrays by `[` a single argument `i` can be a matrix with
as many columns as there are dimensions of `x`; the result is then a
vector with elements corresponding to the sets of indices in each row of
`i`.

An index value of `NULL` is treated as if it were `integer(0)`.

`drop`

For matrices and arrays. If `TRUE` the result is coerced to the lowest
possible dimension (see the examples). This only works for extracting
elements, not for the replacement. See `drop` for further details.
  ------------------ -----------------
  [,Balance-method   R Documentation
  ------------------ -----------------

Extract for Balance class
-------------------------

### Description

Extract for Balance class

### Usage

    ## S4 method for signature 'Balance'
    x[i, j, ..., drop = TRUE]

### Arguments

`j`

ignored

`...`

ignored

`x`

object from which to extract element(s) or in which to replace
element(s).

`i`

indices specifying elements to extract or replace. Indices are `numeric`
or `character` vectors or empty (missing) or `NULL`. Numeric values are
coerced to integer as by `as.integer` (and hence truncated towards
zero). Character vectors will be matched to the `names` of the object
(or for matrices/arrays, the `dimnames`): see ‘Character indices’ below
for further details.

For `[`-indexing only: `i`, `j`, `...` can be logical vectors,
indicating elements/slices to select. Such vectors are recycled if
necessary to match the corresponding extent. `i`, `j`, `...` can also be
negative integers, indicating elements/slices to leave out of the
selection.

When indexing arrays by `[` a single argument `i` can be a matrix with
as many columns as there are dimensions of `x`; the result is then a
vector with elements corresponding to the sets of indices in each row of
`i`.

An index value of `NULL` is treated as if it were `integer(0)`.

`drop`

For matrices and arrays. If `TRUE` the result is coerced to the lowest
possible dimension (see the examples). This only works for extracting
elements, not for the replacement. See `drop` for further details.
  ----------------- -----------------
  submit\_payment   R Documentation
  ----------------- -----------------

Submitting a Payment
--------------------

### Description

Before you can submit a payment, you will need to have three pieces of
information.

### Usage

    submit_payment(payment, secret, client_resource_id)

### Arguments

`payment`

The `"Payment"` object to be submitted.

`secret`

The secret or private key for your Ripple account.

`client_resource_id`

Will uniquely identify this payment. This is a 36-character UUID
(universally unique identifier) value which will uniquely identify this
payment within the `ripple-rest` API. Note that you can use
`generate_uuid` to calculate a UUID value if you do not have a UUID
generator readily available.

### Value

A named list. The first element is the `"client_resource_id"` you gave.
The second element is named `"status_url"` and can be used with
`check_payment_status`.
  ------------------ -----------------
  [,Payment-method   R Documentation
  ------------------ -----------------

Extract for Payment class
-------------------------

### Description

Extract for Payment class

### Usage

    ## S4 method for signature 'Payment'
    x[i, j, ..., drop = TRUE]

### Arguments

`j`

ignored

`...`

ignored

`x`

object from which to extract element(s) or in which to replace
element(s).

`i`

indices specifying elements to extract or replace. Indices are `numeric`
or `character` vectors or empty (missing) or `NULL`. Numeric values are
coerced to integer as by `as.integer` (and hence truncated towards
zero). Character vectors will be matched to the `names` of the object
(or for matrices/arrays, the `dimnames`): see ‘Character indices’ below
for further details.

For `[`-indexing only: `i`, `j`, `...` can be logical vectors,
indicating elements/slices to select. Such vectors are recycled if
necessary to match the corresponding extent. `i`, `j`, `...` can also be
negative integers, indicating elements/slices to leave out of the
selection.

When indexing arrays by `[` a single argument `i` can be a matrix with
as many columns as there are dimensions of `x`; the result is then a
vector with elements corresponding to the sets of indices in each row of
`i`.

An index value of `NULL` is treated as if it were `integer(0)`.

`drop`

For matrices and arrays. If `TRUE` the result is coerced to the lowest
possible dimension (see the examples). This only works for extracting
elements, not for the replacement. See `drop` for further details.
  -------------------------------- -----------------
  [<-,Balance,ANY,ANY,ANY-method   R Documentation
  -------------------------------- -----------------

Replace for Balance class
-------------------------

### Description

Replace for Balance class

### Usage

    ## S4 replacement method for signature 'Balance,ANY,ANY,ANY'
    x[i, j, ...] <- value

### Arguments

`j`

ignored

`...`

ignored

`x`

object from which to extract element(s) or in which to replace
element(s).

`i`

indices specifying elements to extract or replace. Indices are `numeric`
or `character` vectors or empty (missing) or `NULL`. Numeric values are
coerced to integer as by `as.integer` (and hence truncated towards
zero). Character vectors will be matched to the `names` of the object
(or for matrices/arrays, the `dimnames`): see ‘Character indices’ below
for further details.

For `[`-indexing only: `i`, `j`, `...` can be logical vectors,
indicating elements/slices to select. Such vectors are recycled if
necessary to match the corresponding extent. `i`, `j`, `...` can also be
negative integers, indicating elements/slices to leave out of the
selection.

When indexing arrays by `[` a single argument `i` can be a matrix with
as many columns as there are dimensions of `x`; the result is then a
vector with elements corresponding to the sets of indices in each row of
`i`.

An index value of `NULL` is treated as if it were `integer(0)`.

`value`

typically an array-like **R** object of a similar class as `x`.
  ---------------------------------- -----------------
  [<-,Trustline,ANY,ANY,ANY-method   R Documentation
  ---------------------------------- -----------------

Replace for Trustline class
---------------------------

### Description

Replace for Trustline class

### Usage

    ## S4 replacement method for signature 'Trustline,ANY,ANY,ANY'
    x[i, j, ...] <- value

### Arguments

`j`

ignored

`...`

ignored

`x`

object from which to extract element(s) or in which to replace
element(s).

`i`

indices specifying elements to extract or replace. Indices are `numeric`
or `character` vectors or empty (missing) or `NULL`. Numeric values are
coerced to integer as by `as.integer` (and hence truncated towards
zero). Character vectors will be matched to the `names` of the object
(or for matrices/arrays, the `dimnames`): see ‘Character indices’ below
for further details.

For `[`-indexing only: `i`, `j`, `...` can be logical vectors,
indicating elements/slices to select. Such vectors are recycled if
necessary to match the corresponding extent. `i`, `j`, `...` can also be
negative integers, indicating elements/slices to leave out of the
selection.

When indexing arrays by `[` a single argument `i` can be a matrix with
as many columns as there are dimensions of `x`; the result is then a
vector with elements corresponding to the sets of indices in each row of
`i`.

An index value of `NULL` is treated as if it were `integer(0)`.

`value`

typically an array-like **R** object of a similar class as `x`.
  -------------------- -----------------
  [,Trustline-method   R Documentation
  -------------------- -----------------

Extract for Trustline class
---------------------------

### Description

Extract for Trustline class

### Usage

    ## S4 method for signature 'Trustline'
    x[i, j, ..., drop = TRUE]

### Arguments

`j`

ignored

`...`

ignored

`x`

object from which to extract element(s) or in which to replace
element(s).

`i`

indices specifying elements to extract or replace. Indices are `numeric`
or `character` vectors or empty (missing) or `NULL`. Numeric values are
coerced to integer as by `as.integer` (and hence truncated towards
zero). Character vectors will be matched to the `names` of the object
(or for matrices/arrays, the `dimnames`): see ‘Character indices’ below
for further details.

For `[`-indexing only: `i`, `j`, `...` can be logical vectors,
indicating elements/slices to select. Such vectors are recycled if
necessary to match the corresponding extent. `i`, `j`, `...` can also be
negative integers, indicating elements/slices to leave out of the
selection.

When indexing arrays by `[` a single argument `i` can be a matrix with
as many columns as there are dimensions of `x`; the result is then a
vector with elements corresponding to the sets of indices in each row of
`i`.

An index value of `NULL` is treated as if it were `integer(0)`.

`drop`

For matrices and arrays. If `TRUE` the result is coerced to the lowest
possible dimension (see the examples). This only works for extracting
elements, not for the replacement. See `drop` for further details.
  ----------------- -----------------
  Trustline-class   R Documentation
  ----------------- -----------------

Trustline
---------

### Description

A simplified Trustline object used by the `ripple-rest` API.

### Details

All slot lengths must be equal.

### Slots

`account`
  ~ Object of class `"RippleAddress"`. The account from whose
    perspective this trustline is being viewed.

`counterparty`
  ~ Object of class `"RippleAddress"`. The other party in this
    trustline.

`currency`
  ~ Object of class `"Currency"`. The code of the currency in which this
    trustline denotes trust.

`limit`
  ~ Object of class `"numeric"`. The maximum value of the currency that
    the account may hold issued by the counterparty.

`reciprocated_limit`
  ~ Object of class `"numeric"`. The maximum value of the currency that
    the counterparty may hold issued by the account.

`account_allows_rippling`
  ~ Object of class `"logical"`. If `TRUE` it indicates that the account
    allows pairwise rippling out through this trustline.

`counterparty_allows_rippling`
  ~ Object of class `"logical"`. If `TRUE` it indicates that the
    counterparty allows pairwise rippling out through this trustline.

`ledger`
  ~ Object of class `"numeric"`. The index number of the ledger
    containing this trustline or, in the case of historical queries, of
    the transaction that modified this Trustline.

`hash`
  ~ Object of class `"Hash256"`. If this object was returned by a
    historical query this value will be the hash of the transaction that
    modified this Trustline. The transaction hash is used throughout the
    Ripple Protocol to uniquely identify a particular transaction.


  -------------- -----------------
  UINT32-class   R Documentation
  -------------- -----------------

UINT32
------

### Description

A representation of an unsigned 32-bit integer (0-4294967295).
