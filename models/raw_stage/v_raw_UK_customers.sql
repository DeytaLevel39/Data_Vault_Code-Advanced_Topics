select distinct
CUSTOMER_ID,
CUSTOMER_NUMBER,
FIRST_NAME,
LAST_NAME,
LASTMODIFIEDDATE,
CREATEDDATE,
APPLIEDDATE,
CRUD_FLAG,
TITLE
from
    {{ source('dbtvault_bigquery_demo', 'repl_UK_customers') }}