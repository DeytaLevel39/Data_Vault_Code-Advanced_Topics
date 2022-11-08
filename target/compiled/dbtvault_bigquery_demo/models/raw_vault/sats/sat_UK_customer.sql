-- Generated by dbtvault.

    

WITH source_data AS (
    SELECT a.`CUSTOMER_HK`, a.`CUSTOMER_HASHDIFF`, a.`CUSTOMER_ID`, a.`FIRST_NAME`, a.`LAST_NAME`, a.`LASTMODIFIEDDATE`, a.`CREATEDDATE`, a.`APPLIEDDATE`, a.`CRUD_FLAG`, a.`TITLE`, a.`WEALTH_BRACKET`, a.`EFFECTIVE_FROM`, a.`LOAD_DATE`, a.`RECORD_SOURCE`
    FROM `steadfast-task-363413`.`data_vault`.`v_stg_UK_customer` AS a
    WHERE a.`CUSTOMER_HK` IS NOT NULL
),



latest_records AS (
    SELECT a.`CUSTOMER_HK`, a.`CUSTOMER_HASHDIFF`, a.`LOAD_DATE`
    FROM (
        SELECT current_records.`CUSTOMER_HK`, current_records.`CUSTOMER_HASHDIFF`, current_records.`LOAD_DATE`,
            RANK() OVER (
               PARTITION BY current_records.`CUSTOMER_HK`
               ORDER BY current_records.`LOAD_DATE` DESC
            ) AS rank
        FROM `steadfast-task-363413`.`data_vault`.`sat_UK_customer` AS current_records
            JOIN (
                SELECT DISTINCT source_data.`CUSTOMER_HK`
                FROM source_data
            ) AS source_records
                ON current_records.`CUSTOMER_HK` = source_records.`CUSTOMER_HK`
    ) AS a
    WHERE a.rank = 1
),records_to_insert AS (
    SELECT DISTINCT stage.`CUSTOMER_HK`, stage.`CUSTOMER_HASHDIFF`, stage.`CUSTOMER_ID`, stage.`FIRST_NAME`, stage.`LAST_NAME`, stage.`LASTMODIFIEDDATE`, stage.`CREATEDDATE`, stage.`APPLIEDDATE`, stage.`CRUD_FLAG`, stage.`TITLE`, stage.`WEALTH_BRACKET`, stage.`EFFECTIVE_FROM`, stage.`LOAD_DATE`, stage.`RECORD_SOURCE`
    FROM source_data AS stage
    LEFT JOIN latest_records
    ON latest_records.`CUSTOMER_HK` = stage.`CUSTOMER_HK`
        AND latest_records.`CUSTOMER_HASHDIFF` = stage.`CUSTOMER_HASHDIFF`
    WHERE latest_records.`CUSTOMER_HASHDIFF` IS NULL
)

SELECT * FROM records_to_insert