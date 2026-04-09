--=====================================================================

/* 

erp_cust_az12 Files from Bronze layer to Silver Layer after complete testing of Data Quality and Data Completeness
	where data is:
					-	DATA Without any null values(gen)
					-	DATA WITH FIELD HAVING NO BLANK SPACE/ UNWANTED SPACE 
					-	DATA WITH STANDARDIZATION AND CONSISTENCY
					-	Data Integration field are chcked
*/
--==========================================================================

IF OBJECT_ID('Silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE Silver.erp_cust_az12;
GO

CREATE TABLE Silver.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO

INSERT INTO Silver.erp_cust_az12
(
	cid,
	bdate,
	gen
)

SELECT 
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
		ELSE cid
	END cid,

		
	CASE 
		WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	END bdate,

	CASE 
		WHEN gen = 'F' THEN 'Female'
		WHEN gen = 'M' THEN 'Male'
		WHEN gen IS NULL OR gen = ' ' THEN 'N/A'
		
		ELSE gen
	END gen
FROM Bronze.erp_cust_az12
