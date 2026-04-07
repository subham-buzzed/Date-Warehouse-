--=====================================================================

/* 

crm_sales_details Files from Bronze layer to Silver Layer after complete testing of Data Quality and Data Completeness
	where data is:
				Possible Data Quality Checks  with crm_sales_details
					- Dealt with Data with unwanted spaces
					- Data Standardization & Consistency is maintained
					- Data Integration field Checks are done 
					- Handled Invalid Dates
					- Business Rules is Followed
					- Handled all NULL values
*/
--==========================================================================

IF OBJECT_ID('Silver.crm_sales_details','U') IS NOT NULL
	DROP TABLE Silver.crm_sales_details;
GO

CREATE TABLE Silver.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt DATE,
    sls_ship_dt  DATE,
    sls_due_dt   DATE,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO

INSERT INTO Silver.crm_sales_details
(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE
	WHEN LEN(sls_order_dt) != 8 OR sls_order_dt <= 0 
		OR sls_order_dt < 19000101 OR sls_order_dt > 20501231
	THEN NULL
	ELSE CAST(CAST(sls_order_dt AS varchar)AS date)
END sls_order_dt,

CASE
	WHEN LEN(sls_ship_dt) != 8 OR sls_ship_dt <= 0 
		OR sls_ship_dt < 19000101 OR sls_ship_dt > 20501231
	THEN NULL
	ELSE CAST(CAST(sls_ship_dt AS varchar)AS date)
END sls_ship_dt,

CASE
	WHEN LEN(sls_due_dt) != 8 OR sls_due_dt <= 0 
		OR sls_due_dt < 19000101 OR sls_due_dt > 20501231
	THEN NULL
	ELSE CAST(CAST(sls_due_dt AS varchar)AS date)
END sls_due_dt,

CASE 
	WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END sls_sales,

sls_quantity,

CASE 
	WHEN sls_price IS NULL OR sls_price <= 0 
		THEN sls_sales/NULLIF(sls_quantity,0)
	ELSE sls_price
END sls_price
FROM Bronze.crm_sales_details




