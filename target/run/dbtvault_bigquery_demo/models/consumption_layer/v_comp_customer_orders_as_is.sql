

  create or replace view `steadfast-task-363413`.`data_vault`.`v_comp_customer_orders_as_is`
  OPTIONS()
  as with
    c as
        (select customer_hk, customer_number, first_name, last_name
         from `steadfast-task-363413`.`data_vault`.`v_comp_customers_as_is`),
    o as
        (select customer_hk, order_number, order_price, createddate, lastmodifieddate
         from `steadfast-task-363413`.`data_vault`.`v_comp_orders_as_is`),
    joined as
        (select c.customer_number, c.first_name, c.last_name, o.order_number, o.order_price,
         o.createddate, o.lastmodifieddate
         from c, o
         where o.customer_hk = c.customer_hk)
select * from joined;

