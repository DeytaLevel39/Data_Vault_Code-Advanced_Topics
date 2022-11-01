with
    h as
        (select customer_hk, customer_number, record_source
        from {{ ref('hub_customer') }}),
    s_uk as
        (select customer_hk, customer_id, first_name, last_name, lastmodifieddate, createddate,
         applieddate, effective_from, crud_flag, load_date from {{ ref('sat_UK_customer') }}),
    s_uk_1 as
        (select customer_hk, title from {{ ref('sat_UK_customer_1') }}),
    s_uk_2 as
        (select customer_hk, wealth_bracket from {{ ref('sat_UK_customer_2') }}),
    s_us as
        (select customer_hk, customer_id, first_name, last_name, lastmodifieddate, createddate,
         applieddate, effective_from, crud_flag, load_date from {{ ref('sat_US_customer') }}),
    joined as
        (select h.customer_hk, h.customer_number, s_uk.crud_flag, s_uk.customer_id,
                s_uk_1.title, s_uk.first_name, s_uk.last_name, s_uk_2.wealth_bracket, s_uk.lastmodifieddate, s_uk.createddate, s_uk.applieddate,
                s_uk.effective_from, s_uk.load_date, h.record_source,
                row_number() over(partition by s_uk.customer_hk order by s_uk.applieddate desc) as rn
         from h, s_uk, s_uk_1, s_uk_2
         where s_uk.customer_hk = h.customer_hk
         and s_uk_1.customer_hk = h.customer_hk
         and s_uk_2.customer_hk = h.customer_hk
         union all
         select h.customer_hk, h.customer_number, s_us.crud_flag, s_us.customer_id,
                '' as title, s_us.first_name, s_us.last_name, null as wealth_bracket, s_us.lastmodifieddate, s_us.createddate, s_us.applieddate,
                s_us.effective_from, s_us.load_date, h.record_source,
                row_number() over(partition by s_us.customer_hk order by s_us.applieddate desc) as rn
         from h, s_us
         )
select customer_hk, customer_id, customer_number, title, first_name, last_name, wealth_bracket, lastmodifieddate, createddate, applieddate, effective_from, load_date, record_source from joined
where rn = 1 and crud_flag <> 'D'
