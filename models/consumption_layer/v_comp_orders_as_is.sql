with
    h as
        (select order_hk, order_number, record_source from {{ ref('hub_order')}}),
    s as
        (select order_hk, order_id, order_price, lastmodifieddate, createddate, effective_from, load_date,
         crud_flag, row_number() over(partition by order_hk order by lastmodifieddate desc) as rn
         from {{ ref('sat_order')}}),
    co as
        (select order_hk, customer_hk from {{ref ('link_order_customer')}} ),
    joined as
        (select h.order_hk, h.order_number,
            co.customer_hk,
            s.order_id, s.order_price, s.lastmodifieddate, s.createddate, h.record_source, s.effective_from,
            s.load_date, s.crud_flag, s.rn
         from h, s, co
        where s.order_hk = h.order_hk
        and co.order_hk = h.order_hk)
select order_hk, customer_hk, order_id, order_number, order_price, lastmodifieddate, createddate,
effective_from, load_date
from joined
where rn = 1 and crud_flag <> 'D'
