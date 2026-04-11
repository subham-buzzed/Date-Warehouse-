/*

erp_LOC_A101 FILE TRANSFERED FROM BRONZE TO SILVER 
	TRANSFORMATION DONE are  : 
				- Checking Data Integration field and Handling invalidness of the field
				- Data Normalization 
				- Handling Missing values or blank countries codes

*/

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
