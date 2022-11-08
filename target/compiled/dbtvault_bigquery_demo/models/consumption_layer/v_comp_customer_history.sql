with
    h as
        (select customer_hk, customer_number from `steadfast-task-363413`.`data_vault`.`hub_customer`),
    s_uk as
        (select customer_hk, customer_id, first_name, last_name, lastmodifieddate, createddate,
         applieddate, effective_from, crud_flag, load_date from `steadfast-task-363413`.`data_vault`.`sat_UK_customer`),
    s_us as
        (select customer_hk, customer_id, first_name, last_name, lastmodifieddate, createddate,
         applieddate, effective_from, crud_flag, load_date from `steadfast-task-363413`.`data_vault`.`sat_US_customer`),
    joined as
        (select h.customer_hk, h.customer_number, s_uk.customer_id, s_uk.first_name,
        s_uk.last_name, s_uk.lastmodifieddate, s_uk.createddate, s_uk.applieddate,
        s_uk.effective_from, s_uk.crud_flag, s_uk.load_date
        from h, s_uk
        where s_uk.customer_hk = h.customer_hk
        union all
        select h.customer_hk, h.customer_number, s_us.customer_id, s_us.first_name,
        s_us.last_name, s_us.lastmodifieddate, s_us.createddate, s_us.applieddate,
        s_us.effective_from, s_us.crud_flag, s_us.load_date
        from h, s_us
        where s_us.customer_hk = h.customer_hk)
select * from joined