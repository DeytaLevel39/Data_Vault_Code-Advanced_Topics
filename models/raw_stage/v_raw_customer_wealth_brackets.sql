select distinct
ID,
NAME,
DESCRIPTION,
LASTMODIFIEDDATE,
CREATEDDATE
from
    {{ source('dbtvault_bigquery_demo', 'repl_customer_wealth_brackets') }}