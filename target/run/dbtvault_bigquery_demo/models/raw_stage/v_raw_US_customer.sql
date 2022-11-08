

  create or replace view `steadfast-task-363413`.`data_vault`.`v_raw_US_customer`
  OPTIONS()
  as select distinct
c.CUSTOMER_ID,
c.CUSTOMER_NUMBER,
c.FIRST_NAME,
c.LAST_NAME,
c.LASTMODIFIEDDATE,
c.CREATEDDATE,
c.APPLIEDDATE,
c.CRUD_FLAG
from
    `steadfast-task-363413`.`staging`.`repl_US_customers` as c;

