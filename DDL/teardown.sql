-- drop the raw staging views
drop view data_vault.v_raw_UK_customer;
drop view data_vault.v_raw_US_customer;
drop view data_vault.v_raw_UK_order;

-- drop the prepared staging views
drop view data_vault.v_stg_UK_customer;
drop view data_vault.v_stg_US_customer;
drop view data_vault.v_stg_UK_order;

-- drop the raw data vault tables
drop table data_vault.sat_UK_order;
drop table data_vault.sat_UK_customer;
drop table data_vault.sat_US_customer;
drop table data_vault.sat_customer_wealth_bracket;
drop table data_vault.link_customer_order;
drop table data_vault.link_customer_wealth_bracket_customer;
drop table data_vault.hub_order;
drop table data_vault.hub_customer;

--drop the consumption layer views
drop view data_vault.v_comp_customer_history;
drop view data_vault.v_comp_customer_orders_as_is;
drop view data_vault.v_comp_customers_as_is;
drop view data_vault.v_comp_orders_as_is;