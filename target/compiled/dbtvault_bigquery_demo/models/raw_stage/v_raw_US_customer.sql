select distinct
c.CUSTOMER_ID,
c.CUSTOMER_NUMBER,
c.FIRST_NAME,
c.LAST_NAME,
c.LASTMODIFIEDDATE,
c.CREATEDDATE,
c.APPLIEDDATE,
c.CRUD_FLAG
from
    `steadfast-task-363413`.`staging`.`repl_US_customers` as c