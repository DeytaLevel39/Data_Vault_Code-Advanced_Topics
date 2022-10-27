select distinct
CUSTOMER_ID,
CUSTOMER_NUMBER,
FIRST_NAME,
LAST_NAME,
LASTMODIFIEDDATE,
CREATEDDATE,
APPLIEDDATE,
CRUD_FLAG
from
    {{ source('dbtvault_bigquery_demo', 'repl_US_customers') }}