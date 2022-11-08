-- Generated by dbtvault.

    

WITH source_data AS (
    SELECT a.`ORDER_HK`, a.`ORDER_HASHDIFF`, a.`ORDER_ID`, a.`ORDER_PRICE`, a.`CUSTOMER_ID`, a.`LASTMODIFIEDDATE`, a.`CREATEDDATE`, a.`CRUD_FLAG`, a.`EFFECTIVE_FROM`, a.`LOAD_DATE`, a.`RECORD_SOURCE`
    FROM `steadfast-task-363413`.`data_vault`.`v_stg_order` AS a
    WHERE a.`ORDER_HK` IS NOT NULL
),



latest_records AS (
    SELECT a.`ORDER_HK`, a.`ORDER_HASHDIFF`, a.`LOAD_DATE`
    FROM (
        SELECT current_records.`ORDER_HK`, current_records.`ORDER_HASHDIFF`, current_records.`LOAD_DATE`,
            RANK() OVER (
               PARTITION BY current_records.`ORDER_HK`
               ORDER BY current_records.`LOAD_DATE` DESC
            ) AS rank
        FROM `steadfast-task-363413`.`data_vault`.`sat_order` AS current_records
            JOIN (
                SELECT DISTINCT source_data.`ORDER_HK`
                FROM source_data
            ) AS source_records
                ON current_records.`ORDER_HK` = source_records.`ORDER_HK`
    ) AS a
    WHERE a.rank = 1
),records_to_insert AS (
    SELECT DISTINCT stage.`ORDER_HK`, stage.`ORDER_HASHDIFF`, stage.`ORDER_ID`, stage.`ORDER_PRICE`, stage.`CUSTOMER_ID`, stage.`LASTMODIFIEDDATE`, stage.`CREATEDDATE`, stage.`CRUD_FLAG`, stage.`EFFECTIVE_FROM`, stage.`LOAD_DATE`, stage.`RECORD_SOURCE`
    FROM source_data AS stage
    LEFT JOIN latest_records
    ON latest_records.`ORDER_HK` = stage.`ORDER_HK`
        AND latest_records.`ORDER_HASHDIFF` = stage.`ORDER_HASHDIFF`
    WHERE latest_records.`ORDER_HASHDIFF` IS NULL
)

SELECT * FROM records_to_insert