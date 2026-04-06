/*
TO CHECK THE QUALITY AND COMPLETENESS OF THE DATA
*/
--============ DATA DUPLICATES ================
SELECT 
	prd_id,
	Checks
FROM
(
SELECT 
	ROW_NUMBER()  OVER(PARTITION BY prd_id ORDER BY prd_id) Checks,
	*
FROM Silver.crm_prd_info
)T
WHERE Checks != 1 OR prd_id IS NULL

--========== FIELD WITH UNWANTED SPACE ===========

-- FOR prd_key
SELECT 
	 prd_id
FROM  Silver.crm_prd_info
WHERE prd_key != TRIM(prd_key)

-- FOR prd_nm

SELECT 
	prd_id	
FROM  Silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- =========== DATA with Lower case & Uperr case mismatch =============

SELECT 
prd_id
FROM  Silver.crm_prd_info
WHERE prd_line  !=  UPPER(prd_line)

--======== DATA INTEGRATION PROBABLE CHECKS

-- FOR Data integration of prd_info and px_cat_g1v2

SELECT 
	cat_id
FROM  Silver.crm_prd_info
	
WHERE cat_id NOT IN (SELECT id FROM Bronze.erp_px_cat_g1v2)

-- FOR Data integration of prd_info and sales_details

	SELECT 
	prd_key
	FROM Silver.crm_prd_info

-- ======= NULL VALUES prd_cost =========
SELECT
	prd_id,
	prd_cost
FROM  Silver.crm_prd_info
	WHERE prd_cost IS NULL

--=========== INVALID DATES ==============
SELECT 
	prd_id,
	prd_key,
	DATETRUNC(DAY,prd_start_dt) START_DATEs,
	DATETRUNC(DAY,prd_end_dt) END_DATEs
FROM  Silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt
