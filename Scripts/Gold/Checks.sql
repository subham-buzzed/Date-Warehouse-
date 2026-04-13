---============= QUALITY CEHCKS FOR FIELD

-- ============== FIELD: Customer ===========================

--====== DUPLICATE CHECKS ==============
SELECT 
cst_id,
COUNT(*)
FROM
(SELECT  
	c1.cst_id,
	c1.cst_key,
	c1.cst_firstname,
	c1.cst_lastname,
	c1.cst_marital_status,
	c1.cst_gndr,
	c2.bdate,
	c3.cntry
FROM Silver.crm_cust_info c1
	LEFT JOIN Silver.erp_cust_az12 c2
ON c1.cst_key =C2.cid
	LEFT JOIN Silver.erp_loc_a101 c3
ON C1.cst_key = c3.cid)T
GROUP BY cst_id
HAVING COUNT(*) != 1

--============ DATA INTEGRATION CHECKS (Post integration checks)
SELECT DISTINCT
	c1.cst_gndr,
	c2.gen
FROM Silver.crm_cust_info c1
	LEFT JOIN Silver.erp_cust_az12 c2
ON c1.cst_key =C2.cid
	LEFT JOIN Silver.erp_loc_a101 c3
ON C1.cst_key = c3.cid
ORDER BY 1,2

--==================== FIELD: Product ================================

--=========== TO CHECK WHETHER THE DATA IS CURRENT DATA OR NOT ===================

SELECT * FROM Silver.crm_prd_info
WHERE prd_key IN (
	SELECT   DISTINCT prd_key FROM 
(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY p1.prd_key ORDER BY  p1.prd_key,p1.prd_end_dt) csm,
	p1.prd_key
	FROM Silver.crm_prd_info p1
	LEFT JOIN Silver.erp_px_cat_g1v2 p2
	ON p1.cat_id = p2.id
)t
WHERE csm != 1)
ORDER BY prd_key ,prd_end_dt 


--===== CHECKING FOR DUPLICATES ==============
SELECT 
prd_key
FROM
(
SELECT
	p1.prd_id,
	p1.prd_key,
	p1.cat_id,
	P2.cat,
	P2.subcat,
	p1.prd_nm,
	p1.prd_line,
	p1.prd_cost,
	p2.maintenance,
	p1.prd_start_dt
FROM Silver.crm_prd_info p1
	LEFT JOIN Silver.erp_px_cat_g1v2 p2
ON p1.cat_id = p2.id
WHERE p1.prd_end_dt IS NULL)T
GROUP BY prd_key
HAVING COUNT(*) >1

--========== FIELD: SALES(Fact table) ===========================

--========== Foreign key integrity 

SELECT * FROM Gold.fact_sales s
	LEFT JOIN GOLD.dim_product p
ON s.product_key = p.product_key
	LEFT JOIN Gold.dim_customer c
ON s.customer_key = c.customer_key

WHERE C.customer_key IS NULL OR P.product_key IS NULL
	
