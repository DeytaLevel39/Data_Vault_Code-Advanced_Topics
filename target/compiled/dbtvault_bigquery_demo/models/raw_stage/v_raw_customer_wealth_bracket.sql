select distinct
c.ID,
c.NAME,
c.DESCRIPTION,
c.LASTMODIFIEDDATE,
c.CREATEDDATE
from
    `steadfast-task-363413`.`staging`.`repl_customer_wealth_brackets` as c