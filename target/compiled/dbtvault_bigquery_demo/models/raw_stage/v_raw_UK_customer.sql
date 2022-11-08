select distinct
c.CUSTOMER_ID,
c.CUSTOMER_NUMBER,
c.FIRST_NAME,
c.LAST_NAME,
c.LASTMODIFIEDDATE,
c.CREATEDDATE,
c.APPLIEDDATE,
c.CRUD_FLAG,
c.TITLE,
c.WEALTH_BRACKET,
p.ID
from
    `steadfast-task-363413`.`staging`.`repl_UK_customers` as c
left join
    `steadfast-task-363413`.`staging`.`repl_customer_wealth_brackets` as p
on p.id = c.wealth_bracket