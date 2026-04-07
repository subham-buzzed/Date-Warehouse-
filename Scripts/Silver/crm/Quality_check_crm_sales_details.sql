
--====== UNWANTED SPACE IN sls_ord_num FIELD

SELECT * FROM Silver.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

--======FIELD CHECKS FOR DATA INTERGRATION

-- prd_info <-> sls_details
SELECT * FROM Silver.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT sls_prd_key FROM Silver.crm_prd_info)

--cust_info <-> sls_details
SELECT * FROM Silver.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id  FROM Silver.crm_cust_info)

--==== INVALID DATE FIELD CHECKS ===========

--===== sls_order_dt FIELD CHECK
SELECT 
	sls_ord_num,
	sls_order_dt
FROM Silver.crm_sales_details
WHERE LEN(sls_order_dt) != 8
	OR sls_order_dt <= 0 
	OR sls_order_dt < 19000101 
	OR sls_order_dt > 20501231

--===== sls_ship_dt FIELD CHECK

SELECT 
	sls_ord_num,
	sls_ship_dt
FROM Silver.crm_sales_details
WHERE LEN(sls_ship_dt) != 8
	OR sls_ship_dt <= 0 
	OR sls_ship_dt < 19000101 
	OR sls_ship_dt > 20501231

--===== sls_due_dt FIELD CHECK

SELECT 
	sls_ord_num,
	sls_due_dt
FROM Silver.crm_sales_details
WHERE LEN(sls_due_dt) != 8
	OR sls_due_dt <= 0 
	OR sls_due_dt < 19000101 
	OR sls_due_dt > 20501231

-- =========== INVALID DATES CHECKS =============

-- FIELD: sls_order_dt
SELECT 
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM Silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

-- FIELD: sls_ship_dt
SELECT 
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM Silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_ship_dt > sls_due_dt

-- FIELD: sls_due_dt
SELECT
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM Silver.crm_sales_details
WHERE sls_order_dt > sls_due_dt OR sls_ship_dt > sls_due_dt

--====== DATA CONSISTENCY ===========

/*

Fields that will be checked: sls_sales, sls_price,sls_quantity
OTB:
	- They are following the business rules or not
	- Any field got NULL values
	- Any field got 0 OR '-ve' values

[Business Rules : Sales = Quantity * Price]

*/

SELECT 
	sls_sales,
	sls_quantity,
	sls_price
FROM Silver.crm_sales_details
WHERE sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
	OR  sls_sales < 0 OR sls_quantity < 0 OR sls_price < 0
	OR sls_sales != sls_quantity * sls_price
ORDER BY sls_sales,sls_quantity,sls_price
