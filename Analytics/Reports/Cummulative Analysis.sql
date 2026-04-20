--======= CUMMULATIVE ANALYSIS OF SALES ==========

--====== Running totals for every month in each year
SELECT 
	FORMAT(Dates,'yyyy-MMM') order_date,
	Total_sales,
	SUM(Total_sales) OVER(PARTITION BY YEAR(Dates) ORDER BY MONTH(Dates)) Total_running_sales
FROM 
(
SELECT 
	DATETRUNC(MONTH, order_date) Dates,
	SUM(sales) Total_sales
FROM Gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date) 
)T

--====== Running Total Sales in Each year 

SELECT
	YEAR(order_date) order_date,
	Total_sales,
	SUM(Total_sales) OVER(ORDER BY order_date) Running_total_sales,
	Avg_sales,
	AVG(Avg_sales) OVER(ORDER BY order_date) Running_avg_sales
FROM
(
	SELECT 
		DATETRUNC(YEAR,order_date) order_date,
		SUM(sales) Total_sales,
		AVG(sales) Avg_sales
	FROM Gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR,order_date)
)T
