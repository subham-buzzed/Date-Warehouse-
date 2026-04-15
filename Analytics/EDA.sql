--============== EXPLORATION OF DATABASE ================

SELECT * FROM INFORMATION_SCHEMA.TABLES

--==== EXPLORATION OF COLUMNS OF DATABASE =======

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customer'

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_product'


---================ Exlporation of Dimensions =====================

--==== *Exploration of dimension in Customer *=========

-- == DIMENSION 1 : Country

SELECT 
	DISTINCT country
FROM Gold.dim_customer

-- == DIMENSION 2 : Martial Status

SELECT 
	DISTINCT marital_status
FROM Gold.dim_customer

-- == DIMENSION 3 : Gender

SELECT 
DISTINCT gender
FROM Gold.dim_customer

--======== *Dimension exploration in Products* ==========

-- == DIMENSION 1 :sub_category
SELECT 
	DISTINCT sub_category
FROM Gold.dim_product

-- == DIMENSION 2 : product_line

SELECT 
	DISTINCT product_line
FROM Gold.dim_product

-- == DIMENSION 3 : category

SELECT 
	DISTINCT category
FROM Gold.dim_product

--========== EXPLORE ALL CATEGORY

SELECT 
	DISTINCT category,sub_category,product_name
FROM Gold.dim_product
	ORDER BY 1,2,3

---============= DATE EXPLORATION ===============

SELECT
	DATEDIFF(YEAR, MIN(Order_date),MAX(order_date)) Total_year_of_sales
FROM Gold.fact_sales

SELECT 
	DATEDIFF(YEAR, MIN(birth_date),MAX(birth_date)) Range_of_year_customer
FROM Gold.dim_customer

SELECT 
	DATEDIFF(YEAR,MIN(birth_date),GETDATE())  Eldest_age,
	DATEDIFF(YEAR,MAX(birth_date),GETDATE()) Youngest_age
FROM Gold.dim_customer

--==== MEASURE REPORT =====

  SELECT 'TOTAL SALES' AS Measure_Name, 	SUM(sales) AS Measure_value FROM Gold.fact_sales
UNION
SELECT 'TOTAL ITEMS SOLD' , SUM(quantity) FROM Gold.fact_sales
UNION
SELECT 'AVERAGE SELLING PRICE ' , AVG(price) FROM Gold.fact_sales
UNION
SELECT 'TOTAL ITEMS SOLD' , SUM(quantity) FROM Gold.fact_sales
UNION
SELECT 'TOTAL ORDERS', COUNT(DISTINCT order_number) FROM Gold.fact_sales
UNION 
SELECT 'TOTAL CUSTOMERS', COUNT(DISTINCT customer_key) FROM Gold.fact_sales
UNION
SELECT 'TOTAL PRODUCTS', COUNT(DISTINCT product_key ) FROM Gold.fact_sales
UNION 
SELECT 'Customer who ordered', 	COUNT(DISTINCT C.customer_key) Customer_who_ordered 
FROM Gold.fact_sales S LEFT JOIN Gold.dim_customer C ON 
	S.customer_key = C.customer_key
WHERE S.order_number IS NOT NULL

