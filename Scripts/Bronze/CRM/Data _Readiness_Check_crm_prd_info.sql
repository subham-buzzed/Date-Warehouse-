-- DATA QUALITY & DATE COMPLETENESS CHECK
/*
Possible Data Quality Checks  with crm_prd_info
	- Data Duplicates
	- Data with unwanted spaces
	- Data with lower case & upper case mismatch
	- Data Standardization & Consistency 

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
FROM Bronze.crm_prd_info
)T
WHERE Checks != 1 OR prd_id IS NULL

--========== FIELD WITH UNWANTED SPACE ===========

-- FOR prd_key
SELECT 
	 prd_id
FROM Bronze.crm_prd_info 
WHERE prd_key != TRIM(prd_key)

-- FOR prd_nm

SELECT 
	prd_id	
FROM Bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- =========== DATA with Lower case & Uperr case mismatch =============

SELECT 
prd_id
FROM Bronze.crm_prd_info
WHERE prd_line  !=  UPPER(prd_line)

--======== DATA INTEGRATION PROBABLE CHECKS

-- FOR Data integration of prd_info and px_cat_g1v2
SELECT 
cat_id
FROM
	(SELECT 
		prd_key,
		REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id
	FROM Bronze.crm_prd_info
	)T
WHERE cat_id NOT IN (SELECT id FROM Bronze.erp_px_cat_g1v2)

-- FOR Data integration of prd_info and sales_details
SELECT
	Prd_key
 FROM
	(SELECT 
		SUBSTRING(prd_key,7,LEN(prd_key)) Prd_key
	FROM Bronze.crm_prd_info)T
WHERE Prd_key NOT IN (SELECT sls_prd_key FROM Bronze.crm_sales_details)

-- ======= NULL VALUES prd_cost =========
SELECT
	prd_id,
	prd_cost
FROM Bronze.crm_prd_info
	WHERE prd_cost IS NULL
