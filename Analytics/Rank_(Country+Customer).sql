--======== TOP 5 PRODUCT GENERATIING HIGHEST REVENUE

SELECT TOP 5
	RANK() OVER(ORDER BY total_sales DESC) Highest_ranking,
	*
FROM 
(
	SELECT  
		P.product_name,
		SUM(S.sales) total_sales
	FROM Gold.fact_sales S 
	LEFT JOIN Gold.dim_product P
	ON S.product_key = P. product_key
	GROUP BY P.product_name
)T

--======== TOP 5 PRODUCT GENERATIING LOWEST REVENUE

SELECT TOP 5
	RANK() OVER(ORDER BY total_sales  ) Lowest_Ranking,
	*
FROM 
(
	SELECT  
		P.product_name,
		SUM(S.sales) total_sales
	FROM Gold.fact_sales S 
	LEFT JOIN Gold.dim_product P
	ON S.product_key = P. product_key
	GROUP BY P.product_name
)T


--========== TOP 10 CUSTOMERS GENERATING HIGHEST REVENUE ==========

SELECT TOP 10
	RANK() OVER(ORDER BY Total_Revenue DESC) Highest_Ranks,
	*
FROM
(
		SELECT 
		C.names,
		SUM(S.sales) Total_Revenue
	FROM Gold.fact_sales S
	LEFT JOIN Gold.dim_customer C
	ON S.customer_key = C.customer_key
	GROUP BY C.names

)T
--========== 10 CUSTOMER WHO PLACED THE LOWEST AMOUNT OF ORDERS ==========


SELECT TOP 10
	ROW_NUMBER() OVER(ORDER BY Total_orderplaced) Ranks,
	*
FROM 
(
	SELECT 
	C.names,
	COUNT(S.order_number) Total_orderplaced
FROM Gold.fact_sales S LEFT JOIN Gold.dim_customer C
ON S.customer_key = C.customer_key
GROUP BY C.customer_key,C.names
)T
ORDER BY Total_orderplaced
