/* 

Views that can considered as final Fact Table and Dimension Table in Gold layer
Each views has leverage the tranformed data from Silver Layer to produce
  - Clean & Enriched Data
  - Business Ready Data
*/

--========= Dimension tables ====================

--  =================Customer dimension table ====================

CREATE VIEW Gold.dim_customer AS 
SELECT  
	ROW_NUMBER () OVER(ORDER BY cst_id)	customer_key,
	c1.cst_id customer_id,
		c1.cst_key customer_number,
		CONCAT(C1.cst_firstname,' ',c1.cst_lastname) names,
	c1.cst_marital_status marital_status,
	c1.cst_create_date create_date,
	CASE 
		WHEN c1.cst_gndr != 'N/A' THEN c1.cst_gndr
		ELSE COALESCE(c2.gen,'N/A')
	END gender ,
	c2.bdate birth_date,
	c3.cntry country 
FROM Silver.crm_cust_info c1
	LEFT JOIN Silver.erp_cust_az12 c2
ON c1.cst_key =C2.cid
	LEFT JOIN Silver.erp_loc_a101 c3
ON C1.cst_key = c3.cid

--  ================= Product dimension table ====================

CREATE VIEW Gold.dim_product AS
SELECT
	ROW_NUMBER() OVER(ORDER BY p1.prd_start_dt) product_key,
	p1.prd_id product_id,
	p1.prd_key product_number,
	p1.prd_nm product_name,
	p1.cat_id category_id,
	P2.cat category,
	P2.subcat sub_category,
	p2.maintenance,
	p1.prd_line product_line,
	p1.prd_cost product_cost,
	p1.prd_start_dt start_dates
FROM Silver.crm_prd_info p1
	LEFT JOIN Silver.erp_px_cat_g1v2 p2
ON p1.cat_id = p2.id
WHERE p1.prd_end_dt IS NULL

--============== FACT TABLE =============================================
  
--  ================= Sales Fact table ====================

CREATE VIEW Gold.fact_sales AS
	select 
		s1.sls_ord_num order_number,
		p1.product_key,
		c1.customer_key,
		s1.sls_order_dt  order_date,
		s1.sls_ship_dt ship_date,
		s1.sls_due_dt due_date,
		s1.sls_sales sales,
		s1.sls_quantity quantity,
		s1.sls_price price
	from Silver.crm_sales_details s1
		left join Gold.dim_customer c1
	on s1.sls_cust_id = c1.customer_id
		left join Gold.dim_product p1
	on s1.sls_prd_key = p1.product_number

