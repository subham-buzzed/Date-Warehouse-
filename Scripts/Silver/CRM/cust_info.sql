--=====================================================================
/* 
 Files in Silver Layer after complete testing of Data Quality and Data Completeness
  then Data Cleansing was done.
	Where data is:
					-	DATA WITHOUT ABY DUPLICATE AND NULL cst_ID VALUES
					-	DATA WITH FIELD HAVING NO BLANK SPACE/ UNWANTED SPACE 
					-	DATA WITH STANDARDIZATION AND CONSISTENCY

  And then it was Loaded into Silver Layer
*/
--==========================================================================


INSERT INTO Silver.crm_cust_info
(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) cst_firstname,
	TRIM(cst_lastname) cst_lastname,
	CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN  'Married'
		ELSE 'N/A'
	END cst_marital_status,
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'N/A'
	END cst_gndr,
	cst_create_date

FROM 
	(SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) CHECKS
	FROM Bronze.crm_cust_info
		WHERE cst_id IS NOT NULL )T
 WHERE CHECKS = 1  

