----Check for invalid dates
SELECT
NULLIF(sls_ship_dt, 0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_ship_dt) != 8
OR
sls_ship_dt > 20500101 OR sls_order_dt < 19000101

----check for invalid date orders
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_ship_dt > sls_due_dt

---check data consistency: between sales, quantity and proce
-->> sales = quantity * price
-->>values must not be null, zero or negative.

SELECT
sls_sales, 
sls_quantity,
sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

SELECT * FROM silver.crm_sales_details

--identify out-of-range dates
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

----Data standardization and consistency
SELECT DISTINCT
 gen
FROM silver.erp_cust_az12

---data transformation and cleansing
SELECT
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info
WHERE cst_id = 29466

-----check for unwanted space
-----Expectation: No results
SELECT
cst_firstname 
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

---Data standardization and consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

-----DATA stanadrdization and consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101 
