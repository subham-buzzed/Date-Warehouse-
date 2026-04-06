--=============== DUPLICATES ===================
SELECT 
	cst_id,
	Checks
FROM
(
SELECT 
	ROW_NUMBER()  OVER(PARTITION BY cst_id ORDER BY cst_id) Checks,
	*
FROM Silver.crm_prd_info
)T
WHERE Checks != 1 OR cst_id IS NULL


--================== DATA WITH UNWANTED SPACE =============================

--  ID's WITH UNWANTED SPACE IN THE cst_firstname FIELD
SELECT 
	cst_id,
	cst_firstname
FROM Silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

--  ID's WITH UNWANTED SPACE IN THE cst_lastname FIELD
SELECT 
	cst_id,
	cst_lastname
FROM Silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- ID'S WITH UNWANTED SPACE  IN THE cst_marital_status FIELD
SELECT 
	cst_id,
	cst_marital_status
FROM Silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status)

-- ID'S WITH UNWANTED SPACE  IN THE cst_gndr FIELD
SELECT 
	cst_id,
	cst_gndr
FROM Silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

-- ID'S WITH UNWANTED SPACE  IN THE cst_key FIELD
SELECT 
	cst_id,
	cst_key
FROM Silver.crm_cust_info
WHERE cst_key != TRIM(cst_key)

--=================	DATA STANDARDIZATION AND CONSISTENCY ================
 
 -- POSSIBLE VALUES OF cst_marital_status (i.e [S,M NULL] CHECK)
 SELECT 
 DISTINCT cst_marital_status
 FROM Silver.crm_cust_info

  -- POSSIBLE VALUES OF cst_gndr (i.e [F,M NULL] CHECK)
 SELECT 
 DISTINCT cst_gndr
 FROM Silver.crm_cust_info
