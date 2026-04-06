--=====================================================================
/* 

crm_prd_info Files from Bronze layer to Silver Layer after complete handling  of Data Quality and Data Completeness issues,
	where current data :	
					- Has no Data Duplicates
					- Dealt with Data with unwanted spaces
					- Dealt with Data with lower case & upper case mismatch
					- Data Standardization & Consistency is maintained
					- Data Integration field Checks are done 
					- Handled Invalid Dates
*/
--==========================================================================

IF OBJECT_ID('Silver.crm_prd_info','U') IS NOT NULL
	DROP TABLE Silver.crm_prd_info;
GO

CREATE TABLE Silver.crm_prd_info
(
	 prd_id       INT,
	 cat_id       NVARCHAR(50),
     prd_key      NVARCHAR(50),
     prd_nm       NVARCHAR(50),
     prd_cost     INT,
     prd_line     NVARCHAR(50),
     prd_start_dt DATETIME,
     prd_end_dt   DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()

);
GO
	
INSERT INTO Silver.crm_prd_info
(
	prd_id,
	cat_id,
	prd_key,
	prd_name,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT 
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	SUBSTRING(prd_key,7,LEN(prd_key)) prd_key,
	TRIM(prd_name) prd_name,
	ISNULL(prd_cost,0) prd_cost,
	CASE TRIM(prd_line)
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
		WHEN 'T' THEN 'Touring'
		WHEN 'S' THEN 'Other Sales'
		ELSE 'N/A'
	END prd_line,
	CAST(prd_start_dt AS DATE) prd_start_dt,
	CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt ) AS DATE) prd_end_dt
FROM Bronze.crm_prd_info
