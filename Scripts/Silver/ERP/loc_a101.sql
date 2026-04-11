/*

erp_LOC_A101 FILE TRANSFERED FROM BRONZE TO SILVER 
	TRANSFORMATION DONE are  : 
				- Checking Data Integration field and Handling invalidness of the field
				- Data Normalization 
				- Handling Missing values or blank countries codes

*/
IF OBJECT_ID('Silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE Silver.erp_loc_a101;
GO

CREATE TABLE Silver.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO

INSERT INTO Silver.erp_loc_a101
	(
		cid,
		cntry
	)
SELECT 
	REPLACE (cid, '-','') cid,

	CASE 
		WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
		WHEN TRIM(cntry) IN ('DE') THEN 'Germany'
		WHEN TRIM(cntry) IS NULL OR TRIM(cntry) = ''  THEN 'N/A'
		ELSE cntry
	END cntry

FROM Bronze.erp_loc_a101
