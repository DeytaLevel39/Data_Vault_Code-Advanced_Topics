{%- set source_model = ['v_stg_UK_order'] -%}
        {%- set src_pk = 'CUSTOMER_ORDER_HK' -%}
        {%- set src_fk = ['CUSTOMER_HK', 'ORDER_HK'] -%}
        {%- set src_ldts = "LOAD_DATE" -%}
        {%- set src_source = "RECORD_SOURCE" -%}
        
        {{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                         src_source=src_source, source_model=source_model) }}