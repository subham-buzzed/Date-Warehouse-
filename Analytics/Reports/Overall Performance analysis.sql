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
	Total_sales,
	AVG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates) Avg_sales,

	Total_sales - 	AVG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates) AS Avg_diff,
	CASE 
		WHEN Total_sales - 	AVG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates) > 0 THEN 'Above avg'
		WHEN Total_sales - 	AVG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates) < 0 THEN 'Below avg'
		ELSE 'Avg'
	END Product_status,

	ISNULL(CAST(LAG(Dates) OVER(PARTITION BY product_name ORDER BY Dates )  AS varchar(10)),'N/A') Prev_year,
	ISNULL(LAG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates),0) Previous_year_sales,
	
	Total_sales - ISNULL(LAG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates),0) Total_diff,
	
	CASE	
		WHEN Total_sales - ISNULL(LAG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates),0) > 0 AND
		Total_sales - ISNULL(LAG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates),0) != Total_sales THEN ' Good performance'
		WHEN Total_sales - ISNULL(LAG(Total_sales) OVER(PARTITION BY product_name ORDER BY Dates),0) < 0 THEN ' Bad performance'
		ELSE ' Avg performance'
	END Product_status_V_prevyear

FROM Yearly_product_sales
