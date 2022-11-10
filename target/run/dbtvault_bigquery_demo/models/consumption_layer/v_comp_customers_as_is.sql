

  create or replace view `steadfast-task-363413`.`data_vault`.`v_comp_customers_as_is`
  OPTIONS()
  as with
    h as
        (select customer_hk, customer_number, record_source
        from `steadfast-task-363413`.`data_vault`.`hub_customer`),
    s_uk as
        (select customer_hk, customer_id, title, first_name, last_name, wealth_bracket, lastmodifieddate, createddate,
         applieddate, effective_from, crud_flag, load_date from `steadfast-task-363413`.`data_vault`.`sat_UK_customer`),
    s_us as
        (select customer_hk, customer_id, first_name, last_name, lastmodifieddate, createddate,
         applieddate, effective_from, crud_flag, load_date from `steadfast-task-363413`.`data_vault`.`sat_US_customer`),
    joined as
        (select h.customer_hk, h.customer_number, s_uk.crud_flag, s_uk.customer_id,
                s_uk.title, s_uk.first_name, s_uk.last_name, s_uk.wealth_bracket, s_uk.lastmodifieddate, s_uk.createddate, s_uk.applieddate,
                s_uk.effective_from, s_uk.load_date, h.record_source,
                row_number() over(partition by s_uk.customer_hk order by s_uk.applieddate desc) as rn
         from h, s_uk
         where s_uk.customer_hk = h.customer_hk
         union all
         select h.customer_hk, h.customer_number, s_us.crud_flag, s_us.customer_id,
                '' as title, s_us.first_name, s_us.last_name, null as wealth_bracket, s_us.lastmodifieddate, s_us.createddate, s_us.applieddate,
                s_us.effective_from, s_us.load_date, h.record_source,
                row_number() over(partition by s_us.customer_hk order by s_us.applieddate desc) as rn
         from h, s_us
         )
select customer_hk, customer_id, customer_number, title, first_name, last_name, wealth_bracket, lastmodifieddate, createddate, applieddate, effective_from, load_date, record_source
from joined
where rn = 1 and crud_flag <> 'D';

