select distinct
c.ORDER_ID,
c.ORDER_NUMBER,
c.ORDER_PRICE,
c.CUSTOMER_ID,
c.LASTMODIFIEDDATE,
c.CREATEDDATE,
c.CRUD_FLAG,
p.CUSTOMER_NUMBER
from
    `steadfast-task-363413`.`staging`.`repl_orders` as c
left join
    `steadfast-task-363413`.`staging`.`repl_UK_customers` as p
on p.customer_id = c.customer_id