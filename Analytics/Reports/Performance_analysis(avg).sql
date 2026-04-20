--=========== Product PerFormance Analysis =========
 --- METRIC (AVG SALES IN THAT YEAR)
WITH Yearly_product_sales AS
(
	SELECT 
		P.product_name,
		YEAR(order_date) Dates,
		SUM(S.sales) Total_sales
	FROM GOLD.fact_sales S
	LEFT JOIN Gold.dim_product P
	ON S.product_key = P.product_key
		WHERE S.order_date IS NOT NULL
	GROUP BY P.product_name , YEAR(order_date) 
	
)

SELECT 
	product_name,
	Dates,
	AVG(Total_sales) OVER(PARTITION BY product_name) Avg_sales,
	Total_sales,
	Total_sales - 	AVG(Total_sales) OVER(PARTITION BY product_name) AS Diff,
	CASE 
		WHEN Total_sales - 	AVG(Total_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above avg'
		WHEN Total_sales - 	AVG(Total_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below avg'
		ELSE 'Avg'
	END Product_status
FROM Yearly_product_sales
