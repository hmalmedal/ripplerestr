<table>
<tbody>
<tr class="odd">
<td align="left">AccountSettings-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

AccountSettings class
---------------------

### Description

The return value from `change_account_settings` and
`get_account_settings`.

### Details

Each slot length must be `0` or `1`.

### Slots

`account`  
Object of class `"RippleAddress"`. The Ripple address of the account in
question.

`regular_key`  
Object of class `"RippleAddress"`. The hash of an optional additional
public key that can be used for signing and verifying transactions.

`domain`  
Object of class `"character"`. The domain associated with this account.
The `ripple.txt` file can be looked up to verify this information.

`email_hash`  
Object of class `"Hash128"`. The MD5 128-bit hash of the account owner's
email address.

`message_key`  
Object of class `"character"`. An optional public key, represented as
hex, that can be set to allow others to send encrypted messages to the
account owner.

`transfer_rate`  
Object of class `"UINT32"`.

`require_destination_tag`  
Object of class `"logical"`. If set to `TRUE` incoming payments will
only be validated if they include a `destination_tag`. This may be used
primarily by gateways that operate exclusively with hosted wallets.

`require_authorization`  
Object of class `"logical"`. If set to `TRUE` incoming trustlines will
only be validated if this account first creates a trustline to the
counterparty with the authorized flag set to `TRUE`. This may be used by
gateways to prevent accounts unknown to them from holding currencies
they issue.

`disallow_xrp`  
Object of class `"logical"`. If set to `TRUE` incoming XRP payments will
not be allowed.

`password_spent`  
Object of class `"logical"`.

`disable_master`  
Object of class `"logical"`.

`transaction_sequence`  
Object of class `"UINT32"`. The last sequence number of a validated
transaction created by this account.

`trustline_count`  
Object of class `"UINT32"`. The number of trustlines owned by this
account. This value does not include incoming trustlines where this
account has not explicitly reciprocated trust.

`ledger`  
Object of class `"numeric"`. The index number of the ledger containing
these account settings or, in the case of historical queries, of the
transaction that modified these settings.

`hash`  
Object of class `"Hash256"`. If this object was returned by a historical
query this value will be the hash of the transaction that modified these
settings. The transaction hash is used throughout the Ripple Protocol to
uniquely identify a particular transaction.


<table>
<tbody>
<tr class="odd">
<td align="left">Amount-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Amount class
------------

### Description

An Amount on the Ripple Protocol, used also for XRP in the ripple-rest
API.

### Details

Each element of the slots `issuer` and `counterparty` must match the
regular expression `"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"`.

All slot lengths must be equal.

### Slots

`value`  
Object of class `"numeric"`. The quantity of the currency.

`currency`  
Object of class `"Currency"`. The currency expressed as a
three-character code.

`issuer`  
Object of class `"character"`. The Ripple account address of the
currency's issuer or gateway, or an empty string if the currency is XRP.

`counterparty`  
Object of class `"character"`. The Ripple account address of the
currency's issuer or gateway, or an empty string if the currency is XRP.


<table>
<tbody>
<tr class="odd">
<td align="left">as.character-method</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Coerce to character
-------------------

### Description

Coerce an object to `"character"` class.

### Usage

    ## S4 method for signature 'Balance'
    as.character(x, ...)

    ## S4 method for signature 'Amount'
    as.character(x, ...)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>x</code></td>
<td align="left"><p>object to be coerced or tested.</p></td>
</tr>
<tr class="even">
<td align="left"><code>...</code></td>
<td align="left"><p>further arguments passed to or from other methods.</p></td>
</tr>
</tbody>
</table>

### Examples

    x <- Amount(1, "USD")
    as.character(x)
<table>
<tbody>
<tr class="odd">
<td align="left">as.numeric-method</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Coerce to numeric
-----------------

### Description

Extract the slot `"value"` from an object.

### Usage

    ## S4 method for signature 'Balance'
    as.numeric(x, ...)

    ## S4 method for signature 'Amount'
    as.numeric(x, ...)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>x</code></td>
<td align="left"><p>object to be coerced or tested.</p></td>
</tr>
<tr class="even">
<td align="left"><code>...</code></td>
<td align="left"><p>further arguments passed to or from other methods.</p></td>
</tr>
</tbody>
</table>

### Examples

    x <- Amount(1, "USD")
    as.numeric(x)
<table>
<tbody>
<tr class="odd">
<td align="left">Balance-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Balance class
-------------

### Description

A simplified representation of an account Balance.

### Details

Each element of the slot `counterparty` must match the regular
expression `"^$|^r[1-9A-HJ-NP-Za-km-z]{25,33}$"`.

All slot lengths must be equal.

### Slots

`value`  
Object of class `"numeric"`. The quantity of the currency.

`currency`  
Object of class `"Currency"`. The currency expressed as a
three-character code.

`counterparty`  
Object of class `"character"`. The Ripple account address of the
currency's issuer or gateway, or an empty string if the currency is XRP.


<table>
<tbody>
<tr class="odd">
<td align="left">change_account_settings</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Updating Account Settings
-------------------------

### Description

Change an account's settings

### Usage

    change_account_settings(address, secret, transfer_rate, domain, message_key,
      email_hash, disallow_xrp = NA, require_authorization = NA,
      require_destination_tag = NA, password_spent = NA)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account.</p></td>
</tr>
<tr class="even">
<td align="left"><code>secret</code></td>
<td align="left"><p>The secret key for your Ripple account.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>transfer_rate</code></td>
<td align="left"><p>The rate charged each time a holder of currency issued by this account transfers some funds. The default and minimum rate is &quot;1.0&quot;; a rate of &quot;1.01&quot; is a 1% charge on top of the amount being transferred. Up to nine decimal places are supported.</p></td>
</tr>
<tr class="even">
<td align="left"><code>domain</code></td>
<td align="left"><p>The domain name associated with this account.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>message_key</code></td>
<td align="left"><p>An optional public key, represented as a hex string, that can be used to allow others to send encrypted messages to the account owner.</p></td>
</tr>
<tr class="even">
<td align="left"><code>email_hash</code></td>
<td align="left"><p>The MD5 128-bit hash of the account owner's email address, if known.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>disallow_xrp</code></td>
<td align="left"><p>If this is set to <code>TRUE</code>, payments in XRP will not be allowed.</p></td>
</tr>
<tr class="even">
<td align="left"><code>require_authorization</code></td>
<td align="left"><p>If this is set to <code>TRUE</code>, incoming trustlines will only be validated if this account first creates a trustline to the counterparty with the authorized flag set to <code>TRUE</code>. This may be used by gateways to prevent accounts unknown to them from holding currencies they issue.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>require_destination_tag</code></td>
<td align="left"><p>If this is set to <code>TRUE</code>, incoming payments will only be validated if they include a <code>destination_tag</code> value. Note that this is used primarily by gateways that operate exclusively with hosted wallets.</p></td>
</tr>
<tr class="even">
<td align="left"><code>password_spent</code></td>
<td align="left"><p><code>TRUE</code> if the password has been &quot;spent&quot;, else <code>FALSE</code>.</p></td>
</tr>
</tbody>
</table>

### Value

An object of class `"AccountSettings"`
<table>
<tbody>
<tr class="odd">
<td align="left">check_payment_status</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Confirming a Payment
--------------------

### Description

To confirm that your payment has been submitted successfully, you can
call this.

### Usage

    check_payment_status(status_url, address, client_resource_id, hash)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>status_url</code></td>
<td align="left"><p>Return value from <code>submit_payment</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address for the source account. Ignored if <code>status_url</code> is provided.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>client_resource_id</code></td>
<td align="left"><p>Provided to <code>submit_payment</code>. Ignored if <code>status_url</code> is provided.</p></td>
</tr>
<tr class="even">
<td align="left"><code>hash</code></td>
<td align="left"><p>The transaction hash for the desired payment. Ignored if <code>status_url</code> or <code>client_resource_id</code> is provided.</p></td>
</tr>
</tbody>
</table>

### Value

An object of class `"Payment"`
<table>
<tbody>
<tr class="odd">
<td align="left">c-method</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Combine values
--------------

### Description

Combine arguments with the same class.

### Usage

    ## S4 method for signature 'Balance'
    c(x, ..., recursive = FALSE)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>x</code></td>
<td align="left"><p>object to be concatenated.</p></td>
</tr>
<tr class="even">
<td align="left"><code>recursive</code></td>
<td align="left"><p>ignored</p></td>
</tr>
<tr class="odd">
<td align="left"><code>...</code></td>
<td align="left"><p>objects to be concatenated.</p></td>
</tr>
</tbody>
</table>


<table>
<tbody>
<tr class="odd">
<td align="left">Currency-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Currency class
--------------

### Description

The three-character code or hex string used to denote currencies.

### Details

A character vector where each element must match the regular expression
`"^([a-zA-Z0-9]{3}|[A-Fa-f0-9]{40})$"`.

### Examples

    USD <- Currency("USD")
    XAU <- Currency("015841551A748AD2C1F76FF6ECB0CCCD00000000")
<table>
<tbody>
<tr class="odd">
<td align="left">currency</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `currency` value
------------------------

### Description

Access the `currency` slot.

### Usage

    currency(object)

    ## S4 method for signature 'Balance'
    currency(object)

    ## S4 method for signature 'Amount'
    currency(object)

    ## S4 method for signature 'Trustline'
    currency(object)

    ## S4 replacement method for signature 'Balance,Currency'
    currency(object) <- value

    ## S4 replacement method for signature 'Amount,Currency'
    currency(object) <- value

    ## S4 replacement method for signature 'Trustline,Currency'
    currency(object) <- value

    ## S4 replacement method for signature 'Balance,character'
    currency(object) <- value

    ## S4 replacement method for signature 'Amount,character'
    currency(object) <- value

    ## S4 replacement method for signature 'Trustline,character'
    currency(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object with currency slot.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;Currency&quot;</code> or class <code>&quot;character&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"Currency"`.

### Examples

    x <- Amount(1, "USD")
    currency(x) <- "EUR"
<table>
<tbody>
<tr class="odd">
<td align="left">destination_balance_changes</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get `destination_balance_changes` value
---------------------------------------

### Description

Access the `destination_balance_changes` slot.

### Usage

    destination_balance_changes(object)

    ## S4 method for signature 'Payment'
    destination_balance_changes(object)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"Amount"`.
<table>
<tbody>
<tr class="odd">
<td align="left">destination_tag</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `destination_tag` value
-------------------------------

### Description

Access the `destination_tag` slot.

### Usage

    destination_tag(object)

    ## S4 method for signature 'Payment'
    destination_tag(object)

    ## S4 replacement method for signature 'Payment,UINT32'
    destination_tag(object) <- value

    ## S4 replacement method for signature 'Payment,ANY'
    destination_tag(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;UINT32&quot;</code> or class <code>&quot;ANY&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"UINT32"`.
<table>
<tbody>
<tr class="odd">
<td align="left">extract-method</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Extract/replace parts of object
-------------------------------

### Description

Extract or replace parts of an object.

### Usage

    ## S4 method for signature 'Balance'
    x[i]

    ## S4 method for signature 'Trustline'
    x[i]

    ## S4 method for signature 'Amount'
    x[i]

    ## S4 method for signature 'Payment'
    x[i]

    ## S4 replacement method for signature 'Balance,ANY,missing,Balance'
    x[i] <- value

    ## S4 replacement method for signature 'Trustline,ANY,missing,Trustline'
    x[i] <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>x</code></td>
<td align="left"><p>object from which to extract element(s) or in which to replace element(s).</p></td>
</tr>
<tr class="even">
<td align="left"><code>i</code></td>
<td align="left"><p>indices specifying elements to extract or replace. Indices are <code>numeric</code> or <code>character</code> vectors or empty (missing) or <code>NULL</code>. Numeric values are coerced to integer as by <code>as.integer</code> (and hence truncated towards zero). Character vectors will be matched to the <code>names</code> of the object (or for matrices/arrays, the <code>dimnames</code>): see ‘Character indices’ below for further details.</p>
<p>For <code>[</code>-indexing only: <code>i</code>, <code>j</code>, <code>...</code> can be logical vectors, indicating elements/slices to select. Such vectors are recycled if necessary to match the corresponding extent. <code>i</code>, <code>j</code>, <code>...</code> can also be negative integers, indicating elements/slices to leave out of the selection.</p>
<p>When indexing arrays by <code>[</code> a single argument <code>i</code> can be a matrix with as many columns as there are dimensions of <code>x</code>; the result is then a vector with elements corresponding to the sets of indices in each row of <code>i</code>.</p>
<p>An index value of <code>NULL</code> is treated as if it were <code>integer(0)</code>.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>value</code></td>
<td align="left"><p>typically an array-like <strong>R</strong> object of a similar class as <code>x</code>.</p></td>
</tr>
</tbody>
</table>


<table>
<tbody>
<tr class="odd">
<td align="left">generate_uuid</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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
<table>
<tbody>
<tr class="odd">
<td align="left">get_account_balances</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Account Balances
----------------

### Description

Retrieve the current balances for the given Ripple account.

### Usage

    get_account_balances(address, currency, counterparty)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account</p></td>
</tr>
<tr class="even">
<td align="left"><code>currency</code></td>
<td align="left"><p>Three letter currency denominations</p></td>
</tr>
<tr class="odd">
<td align="left"><code>counterparty</code></td>
<td align="left"><p>The Ripple address of the counterparty trusted</p></td>
</tr>
</tbody>
</table>

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
<table>
<tbody>
<tr class="odd">
<td align="left">get_account_payments</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account</p></td>
</tr>
<tr class="even">
<td align="left"><code>source_account</code></td>
<td align="left"><p>Filter the results to only include payments sent by the given account.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>destination_account</code></td>
<td align="left"><p>Filter the results to only include payments received by the given account.</p></td>
</tr>
<tr class="even">
<td align="left"><code>exclude_failed</code></td>
<td align="left"><p>If set to <code>TRUE</code>, the results will only include payments which were successfully validated and written into the ledger. Otherwise, failed payments will be included. Defaults to <code>FALSE</code>.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>direction</code></td>
<td align="left"><p>Limit the results to only include the given type of payments. The following direction values are currently supported: <code>incoming</code>, <code>outgoing</code>, <code>pending</code></p></td>
</tr>
<tr class="even">
<td align="left"><code>earliest_first</code></td>
<td align="left"><p>If set to <code>TRUE</code>, the payments will be returned in ascending date order. Otherwise, the payments will be returned in descending date order (ie, the most recent payment will be returned first). Defaults to <code>FALSE</code>.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>start_ledger</code></td>
<td align="left"><p>The index for the starting ledger. If <code>earliest_first</code> is <code>TRUE</code>, this will be the oldest ledger to be queried; otherwise, it will be the most recent ledger. Defaults to the first ledger in the <code>rippled</code> server's database.</p></td>
</tr>
<tr class="even">
<td align="left"><code>end_ledger</code></td>
<td align="left"><p>The index for the ending ledger. If <code>earliest_first</code> is <code>TRUE</code>, this will be the most recent ledger to be queried; otherwise, it will be the oldest ledger. Defaults to the most recent ledger in the <code>rippled</code> server's database.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>results_per_page</code></td>
<td align="left"><p>The maximum number of payments to be returned at once. Defaults to 10.</p></td>
</tr>
<tr class="even">
<td align="left"><code>page</code></td>
<td align="left"><p>The page number to be returned. The first page of results will have page number 1, the second page will have page number 2, and so on. Defaults to 1.</p></td>
</tr>
</tbody>
</table>

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
<table>
<tbody>
<tr class="odd">
<td align="left">get_account_settings</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Account Settings
----------------

### Description

You can retrieve an account's settings. The server will return a list of
the current settings in force for the given account.

### Usage

    get_account_settings(address)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account</p></td>
</tr>
</tbody>
</table>

### Value

An object of class `"AccountSettings"`
<table>
<tbody>
<tr class="odd">
<td align="left">get_account_trustlines</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Reviewing Trustlines
--------------------

### Description

Retrieves all trustlines associated with the Ripple address.

### Usage

    get_account_trustlines(address, currency, counterparty)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account</p></td>
</tr>
<tr class="even">
<td align="left"><code>currency</code></td>
<td align="left"><p>Three letter currency denominations</p></td>
</tr>
<tr class="odd">
<td align="left"><code>counterparty</code></td>
<td align="left"><p>The Ripple address of the counterparty trusted</p></td>
</tr>
</tbody>
</table>

### Details

The parameters `currency` and `counterparty` are supported to provide
additional filtering.

### Value

An object of class `"Trustline"`
<table>
<tbody>
<tr class="odd">
<td align="left">get_notification</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account</p></td>
</tr>
<tr class="even">
<td align="left"><code>hash</code></td>
<td align="left"><p>Transaction hash</p></td>
</tr>
</tbody>
</table>

### Value

An object of class `"Notification"`
<table>
<tbody>
<tr class="odd">
<td align="left">get_payment_paths</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address for the source account.</p></td>
</tr>
<tr class="even">
<td align="left"><code>destination_account</code></td>
<td align="left"><p>The Ripple address for the destination account.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>destination_amount</code></td>
<td align="left"><p>An object of class <code>&quot;Amount&quot;</code>. The amount to be sent to the destination account.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>The quantity of the currency. Ignored if <code>destination_amount</code> is provided.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>currency</code></td>
<td align="left"><p>The currency expressed as a three-character code. Ignored if <code>destination_amount</code> is provided.</p></td>
</tr>
<tr class="even">
<td align="left"><code>issuer</code></td>
<td align="left"><p>The Ripple account address of the currency's issuer or gateway, or an empty string if the currency is XRP. Ignored if <code>destination_amount</code> is provided.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>source_currencies</code></td>
<td align="left"><p>A string or an object of class <code>&quot;Amount&quot;</code>. This is used to filter the returned list of possible payments. Each source currency can be specified either as a currency code, or as a currency code and issuer. If the issuer is not specified for a currency other than XRP, then the results will be limited to the specified currency, but any issuer for that currency will be included in the results. The string should be a comma-separated list of source currencies. Each source currency can be specified either as a currency code (eg, <code>USD</code>), or as a currency code and issuer (eg, <code>USD+r...</code>).</p></td>
</tr>
</tbody>
</table>

### Value

An object of class `"Payment"`
<table>
<tbody>
<tr class="odd">
<td align="left">get_server_status</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get Server Status
-----------------

### Description

Retrieve information about the current status of the `ripple-rest` API
and the `rippled` server it is connected to.

### Usage

    get_server_status()

### Value

A list of lists
<table>
<tbody>
<tr class="odd">
<td align="left">get_transaction</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>hash</code></td>
<td align="left"><p>Transaction hash</p></td>
</tr>
</tbody>
</table>

### Value

A list
<table>
<tbody>
<tr class="odd">
<td align="left">Hash128-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Hash128 class
-------------

### Description

The hex representation of a 128-bit hash.

### Details

A character vector where each element must match the regular expression
`"^$|^[A-Fa-f0-9]{32}$"`.
<table>
<tbody>
<tr class="odd">
<td align="left">Hash256-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Hash256 class
-------------

### Description

The hex representation of a 256-bit hash.

### Details

A character vector where each element must match the regular expression
`"^$|^[A-Fa-f0-9]{64}$"`.
<table>
<tbody>
<tr class="odd">
<td align="left">has_ledger</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Check for valid `ledger` slot
-----------------------------

### Description

Checks whether an object has a valid `ledger` slot.

### Usage

    has_ledger(object)

    ## S4 method for signature 'Payment'
    has_ledger(object)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

`TRUE` or `FALSE`.
<table>
<tbody>
<tr class="odd">
<td align="left">invoice_id</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `invoice_id` value
--------------------------

### Description

Access the `invoice_id` slot.

### Usage

    invoice_id(object)

    ## S4 method for signature 'Payment'
    invoice_id(object)

    ## S4 replacement method for signature 'Payment,Hash256'
    invoice_id(object) <- value

    ## S4 replacement method for signature 'Payment,character'
    invoice_id(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;Hash256&quot;</code> or class <code>&quot;character&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"Hash256"`.
<table>
<tbody>
<tr class="odd">
<td align="left">is_server_connected</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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
<table>
<tbody>
<tr class="odd">
<td align="left">length-method</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Length of object
----------------

### Description

Get the length of an object.

### Usage

    ## S4 method for signature 'Balance'
    length(x)

    ## S4 method for signature 'Notification'
    length(x)

    ## S4 method for signature 'Trustline'
    length(x)

    ## S4 method for signature 'Amount'
    length(x)

    ## S4 method for signature 'Payment'
    length(x)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>x</code></td>
<td align="left"><p>an <strong>R</strong> object. For replacement, a vector or factor.</p></td>
</tr>
</tbody>
</table>

### Examples

    x <- Amount(1, "USD")
    length(x)
<table>
<tbody>
<tr class="odd">
<td align="left">no_direct_ripple</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `no_direct_ripple` flag
-------------------------------

### Description

Access the `no_direct_ripple` slot.

### Usage

    no_direct_ripple(object)

    ## S4 method for signature 'Payment'
    no_direct_ripple(object)

    ## S4 replacement method for signature 'Payment,logical'
    no_direct_ripple(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;logical&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"logical"`.
<table>
<tbody>
<tr class="odd">
<td align="left">Notification-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Notification class
------------------

### Description

The return value from `get_notification`.

### Details

All slot lengths must be equal.

### Slots

`account`  
Object of class `"RippleAddress"`. The Ripple address of the account to
which the notification pertains.

`type`  
Object of class `"character"`. The resource type this notification
corresponds to. Possible values are `"payment"`, `"order"`,
`"trustline"`, `"accountsettings"`.

`direction`  
Object of class `"character"`. The direction of the transaction, from
the perspective of the account being queried. Possible values are
`"incoming"`, `"outgoing"`, and `"passthrough"`.

`state`  
Object of class `"character"`. The state of the transaction from the
perspective of the Ripple Ledger. Possible values are `"validated"` and
`"failed"`.

`result`  
Object of class `"character"`. The rippled code indicating the success
or failure type of the transaction. The code `"tesSUCCESS"` indicates
that the transaction was successfully validated and written into the
Ripple Ledger. All other codes will begin with the following prefixes:
`"tec"`, `"tef"`, `"tel"`, or `"tej"`.

`ledger`  
Object of class `"numeric"`. The index number of the ledger containing
the validated or failed transaction. Failed payments will only be
written into the Ripple Ledger if they fail after submission to a
rippled and a Ripple Network fee is claimed.

`hash`  
Object of class `"Hash256"`. The 256-bit hash of the transaction. This
is used throughout the Ripple protocol as the unique identifier for the
transaction.

`timestamp`  
Object of class `"POSIXct"`. The timestamp representing when the
transaction was validated and written into the Ripple ledger.

`transaction_url`  
Object of class `"character"`. An URL that can be used to fetch the full
resource this notification corresponds to.

`previous_notification_url`  
Object of class `"character"`. An URL that can be used to fetch the
notification that preceded this one chronologically.

`next_notification_url`  
Object of class `"character"`. An URL that can be used to fetch the
notification that followed this one chronologically.


<table>
<tbody>
<tr class="odd">
<td align="left">partial_payment</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `partial_payment` flag
------------------------------

### Description

Access the `partial_payment` slot.

### Usage

    partial_payment(object)

    ## S4 method for signature 'Payment'
    partial_payment(object)

    ## S4 replacement method for signature 'Payment,logical'
    partial_payment(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;logical&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"logical"`.
<table>
<tbody>
<tr class="odd">
<td align="left">Payment-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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
Object of class `"RippleAddress"`. The Ripple account address of the
Payment sender.

`source_tag`  
Object of class `"UINT32"`. An unsigned 32-bit integer most commonly
used to refer to a sender's hosted account at a Ripple gateway.

`source_amount`  
Object of class `"Amount"`. An optional amount that can be specified to
constrain cross-currency payments.

`source_slippage`  
Object of class `"numeric"`. An optional cushion for the `source_amount`
to increase the likelihood that the payment will succeed. The
`source_account` will never be charged more than `source_amount@value` +
`source_slippage`.

`destination_account`  
Object of class `"RippleAddress"`.

`destination_tag`  
Object of class `"UINT32"`. An unsigned 32-bit integer most commonly
used to refer to a receiver's hosted account at a Ripple gateway.

`destination_amount`  
Object of class `"Amount"`. The amount the `destination_account` will
receive.

`invoice_id`  
Object of class `"Hash256"`. A 256-bit hash that can be used to identify
a particular payment.

`paths`  
Object of class `"character"`. A "stringified" version of the Ripple
PathSet structure that users should treat as opaque.

`partial_payment`  
Object of class `"logical"`. A boolean that, if set to `TRUE`, indicates
that this payment should go through even if the whole amount cannot be
delivered because of a lack of liquidity or funds in the
`source_account` account.

`no_direct_ripple`  
Object of class `"logical"`. A boolean that can be set to `TRUE` if
paths are specified and the sender would like the Ripple Network to
disregard any direct paths from the `source_account` to the
`destination_account`. This may be used to take advantage of an
arbitrage opportunity or by gateways wishing to issue balances from a
hot wallet to a user who has mistakenly set a trustline directly to the
hot wallet.

`direction`  
Object of class `"character"`. The direction of the payment, from the
perspective of the account being queried. Possible values are
`"incoming"`, `"outgoing"`, and `"passthrough"`.

`state`  
Object of class `"character"`. The state of the payment from the
perspective of the Ripple Ledger. Possible values are `"validated"` and
`"failed"` and `"new"` if the payment has not been submitted yet.

`result`  
Object of class `"character"`. The rippled code indicating the success
or failure type of the payment. The code `"tesSUCCESS"` indicates that
the payment was successfully validated and written into the Ripple
Ledger. All other codes will begin with the following prefixes: `"tec"`,
`"tef"`, `"tel"`, or `"tej"`.

`ledger`  
Object of class `"numeric"`. The index number of the ledger containing
the validated or failed payment. Failed payments will only be written
into the Ripple Ledger if they fail after submission to a rippled and a
Ripple Network fee is claimed.

`hash`  
Object of class `"Hash256"`. The 256-bit hash of the payment. This is
used throughout the Ripple protocol as the unique identifier for the
transaction.

`timestamp`  
Object of class `"POSIXct"`. The timestamp representing when the payment
was validated and written into the Ripple ledger.

`fee`  
Object of class `"numeric"`. The Ripple Network transaction fee,
represented in whole XRP (NOT "drops", or millionths of an XRP, which is
used elsewhere in the Ripple protocol).

`source_balance_changes`  
Object of class `"Amount"`. Parsed from the validated transaction
metadata, this represents all of the changes to balances held by the
`source_account`. Most often this will have one amount representing the
Ripple Network fee and, if the `source_amount` was not XRP, one amount
representing the actual `source_amount` that was sent.

`destination_balance_changes`  
Object of class `"Amount"`. Parsed from the validated transaction
metadata, this represents the changes to balances held by the
`destination_account`. For those receiving payments this is important to
check because if the `partial_payment` flag is set this value may be
less than the `destination_amount`.


<table>
<tbody>
<tr class="odd">
<td align="left">ResourceId-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

ResourceId class
----------------

### Description

A client-supplied unique identifier (ideally a UUID) for this
transaction used to prevent duplicate payments and help confirm the
transaction's final status. All ASCII printable characters are allowed.
Note that 256-bit hex strings are disallowed because of the potential
confusion with transaction hashes.

### Details

A character vector where each element must match the regular expression
`"^(?!$|^[A-Fa-f0-9]{64})[ -~]{1,255}$"`.
<table>
<tbody>
<tr class="odd">
<td align="left">RippleAddress-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

RippleAddress class
-------------------

### Description

A Ripple account address.

### Details

A character vector where each element must match the regular expression
`"^r[1-9A-HJ-NP-Za-km-z]{25,33}$"`.

### Examples

    root_account <- RippleAddress("rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh")
<table>
<tbody>
<tr class="odd">
<td align="left">ripplerestr</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

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
<table>
<tbody>
<tr class="odd">
<td align="left">set_account_trustline</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Granting a Trustline
--------------------

### Description

A trustline can also updated and simply set with a currency, amount,
counterparty combination by submitting to this endpoint.

### Usage

    set_account_trustline(address, secret, amount, allows_rippling = NA, limit,
      currency, counterparty)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>address</code></td>
<td align="left"><p>The Ripple address of the desired account</p></td>
</tr>
<tr class="even">
<td align="left"><code>secret</code></td>
<td align="left"><p>The secret key for your Ripple account.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>amount</code></td>
<td align="left"><p>Object of class <code>&quot;Amount&quot;</code>. The limit, currency and counterparty for the trustline.</p></td>
</tr>
<tr class="even">
<td align="left"><code>allows_rippling</code></td>
<td align="left"><p><code>TRUE</code> or <code>FALSE</code>. Allow rippling or not for the trustline.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>limit</code></td>
<td align="left"><p>A number indicating the maximum you are willing to trust. Ignored if <code>amount</code> is provided.</p></td>
</tr>
<tr class="even">
<td align="left"><code>currency</code></td>
<td align="left"><p>Three letter currency denomination. Ignored if <code>amount</code> is provided.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>counterparty</code></td>
<td align="left"><p>Ripple address of the counterparty trusted. Ignored if <code>amount</code> is provided.</p></td>
</tr>
</tbody>
</table>

### Value

An object of class `"Trustline"`
<table>
<tbody>
<tr class="odd">
<td align="left">show-method</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Show object
-----------

### Description

Display an object.

### Usage

    ## S4 method for signature 'Balance'
    show(object)

    ## S4 method for signature 'Amount'
    show(object)

    ## S4 method for signature 'AccountSettings'
    show(object)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Any R object</p></td>
</tr>
</tbody>
</table>


<table>
<tbody>
<tr class="odd">
<td align="left">source_amount</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get `source_amount` value
-------------------------

### Description

Access the `source_amount` slot.

### Usage

    source_amount(object)

    ## S4 method for signature 'Payment'
    source_amount(object)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"Amount"`.
<table>
<tbody>
<tr class="odd">
<td align="left">source_balance_changes</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get `source_balance_changes` value
----------------------------------

### Description

Access the `source_balance_changes` slot.

### Usage

    source_balance_changes(object)

    ## S4 method for signature 'Payment'
    source_balance_changes(object)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"Amount"`.
<table>
<tbody>
<tr class="odd">
<td align="left">source_slippage</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `source_slippage` value
-------------------------------

### Description

Access the `source_slippage` slot.

### Usage

    source_slippage(object)

    ## S4 method for signature 'Payment'
    source_slippage(object)

    ## S4 replacement method for signature 'Payment,numeric'
    source_slippage(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;numeric&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"numeric"`.
<table>
<tbody>
<tr class="odd">
<td align="left">source_tag</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get/set `source_tag` value
--------------------------

### Description

Access the `source_tag` slot.

### Usage

    source_tag(object)

    ## S4 method for signature 'Payment'
    source_tag(object)

    ## S4 replacement method for signature 'Payment,UINT32'
    source_tag(object) <- value

    ## S4 replacement method for signature 'Payment,ANY'
    source_tag(object) <- value

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;Payment&quot;</code>.</p></td>
</tr>
<tr class="even">
<td align="left"><code>value</code></td>
<td align="left"><p>Object of class <code>&quot;UINT32&quot;</code> or class <code>&quot;ANY&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

Object of class `"UINT32"`.
<table>
<tbody>
<tr class="odd">
<td align="left">submit_payment</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Submitting a Payment
--------------------

### Description

Before you can submit a payment, you will need to have three pieces of
information.

### Usage

    submit_payment(payment, secret, client_resource_id)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>payment</code></td>
<td align="left"><p>The <code>&quot;Payment&quot;</code> object to be submitted.</p></td>
</tr>
<tr class="even">
<td align="left"><code>secret</code></td>
<td align="left"><p>The secret or private key for your Ripple account.</p></td>
</tr>
<tr class="odd">
<td align="left"><code>client_resource_id</code></td>
<td align="left"><p>Will uniquely identify this payment. This is a 36-character UUID (universally unique identifier) value which will uniquely identify this payment within the <code>ripple-rest</code> API. Note that you can use <code>generate_uuid</code> to calculate a UUID value if you do not have a UUID generator readily available.</p></td>
</tr>
</tbody>
</table>

### Value

A named list. The first element is the `"client_resource_id"` you gave.
The second element is named `"status_url"` and can be used with
`check_payment_status`.
<table>
<tbody>
<tr class="odd">
<td align="left">transfer_rate</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Get `transfer_rate` value
-------------------------

### Description

Access the `transfer_rate` slot.

### Usage

    transfer_rate(object)

    ## S4 method for signature 'AccountSettings'
    transfer_rate(object)

### Arguments

<table>
<col width="50%" />
<col width="50%" />
<tbody>
<tr class="odd">
<td align="left"><code>object</code></td>
<td align="left"><p>Object of class <code>&quot;AccountSettings&quot;</code>.</p></td>
</tr>
</tbody>
</table>

### Value

The transfer rate as `"numeric"`.
<table>
<tbody>
<tr class="odd">
<td align="left">Trustline-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

Trustline class
---------------

### Description

A simplified Trustline object used by the `ripple-rest` API.

### Details

All slot lengths must be equal.

### Slots

`account`  
Object of class `"RippleAddress"`. The account from whose perspective
this trustline is being viewed.

`counterparty`  
Object of class `"RippleAddress"`. The other party in this trustline.

`currency`  
Object of class `"Currency"`. The code of the currency in which this
trustline denotes trust.

`limit`  
Object of class `"numeric"`. The maximum value of the currency that the
account may hold issued by the counterparty.

`reciprocated_limit`  
Object of class `"numeric"`. The maximum value of the currency that the
counterparty may hold issued by the account.

`account_allows_rippling`  
Object of class `"logical"`. If `TRUE` it indicates that the account
allows pairwise rippling out through this trustline.

`counterparty_allows_rippling`  
Object of class `"logical"`. If `TRUE` it indicates that the
counterparty allows pairwise rippling out through this trustline.

`ledger`  
Object of class `"numeric"`. The index number of the ledger containing
this trustline or, in the case of historical queries, of the transaction
that modified this Trustline.

`hash`  
Object of class `"Hash256"`. If this object was returned by a historical
query this value will be the hash of the transaction that modified this
Trustline. The transaction hash is used throughout the Ripple Protocol
to uniquely identify a particular transaction.


<table>
<tbody>
<tr class="odd">
<td align="left">UINT32-class</td>
<td align="left">R Documentation</td>
</tr>
</tbody>
</table>

UINT32 class
------------

### Description

A representation of an unsigned 32-bit integer (0-4294967295).
