--============ Customer Magnitude by gender n country
-- BY COUNTRY 
SELECT 
	C.country,
	COUNT(DISTINCT C.customer_key) Customer_Per_country 
FROM GolD.fact_sales S LEFT JOIN Gold.dim_customer C
	ON S.customer_key = C.customer_key
GROUP BY C.country
-- BY GENDER
SELECT 
	C.gender,
	COUNT(DISTINCT C.customer_key) Customer_Per_country 
FROM GolD.fact_sales S LEFT JOIN Gold.dim_customer C
	ON S.customer_key = C.customer_key
GROUP BY C.gender
-- BY BOTH COUNTRY AND GENDER 
SELECT 
	C.country,
	C.gender,
	COUNT(DISTINCT C.customer_key) Customer_Per_country 
FROM GolD.fact_sales S LEFT JOIN Gold.dim_customer C
	ON S.customer_key = C.customer_key
GROUP BY C.country,C.gender
ORDER BY 1,2,3 DESC
  
--========= Magnitude of Category BY Total_revenue/total_orders ================

SELECT 
  P.category,
  COUNT(DISTINCT S.product_key) Total_Product_by_Category,
  SUM(S.price) Total_revenue_per_category
FROM Gold.fact_sales S LEFT JOIN GOLD.dim_product P
ON S.product_key = P.product_key
GROUP BY P.category

--======= Magnitude of Category by avg_sales ====
SELECT 
	category,
	AVG(product_cost) Avg_price_per_Category
FROM Gold.dim_product
GROUP BY category

--======== Magnitude oF Total revenue by each customer ========

SELECT 
	C.customer_key,
	C.names,
	SUM(S.sales) Totalsales_by_each_customer
FROM Gold.fact_sales S LEFT JOIN Gold.dim_customer C
ON S .customer_key = C.customer_key
	GROUP BY C.customer_key,C.names
	ORDER BY Totalsales_by_each_customer DESC

