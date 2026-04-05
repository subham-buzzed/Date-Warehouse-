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