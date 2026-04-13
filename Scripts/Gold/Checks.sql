---============= QUALITY CEHCKS FOR FIELD

-- ============== FIELD: Customer ===========================

--====== DUPLICATE CHECKS ==============

SELECT 
	customer_id,
	COUNT(*)
FROM Gold.dim_customer
GROUP BY customer_id 
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
	product_id,
	COUNT(*)
FROM Gold.dim_product
GROUP BY product_id
HAVING COUNT(*) !=1 
	
--========== FIELD: SALES(Fact table) ===========================

--========== Foreign key integrity 

SELECT * FROM Gold.fact_sales s
	LEFT JOIN GOLD.dim_product p
ON s.product_key = p.product_key
	LEFT JOIN Gold.dim_customer c
ON s.customer_key = c.customer_key

WHERE C.customer_key IS NULL OR P.product_key IS NULL
	
