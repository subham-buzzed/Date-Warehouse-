/* 
	Category Analysis report 
	
	- Category contribution towards towards the overall sales

	THIS INSIGHTS WILL HELP TO REPORT A PIE CHART THAT VISUALIZE CATEGORY ON THE BASIS OF SALES CONTRIBUTION

*/
WITH Category_sales AS
(
	SELECT 
		P.category,
		SUM(S.sales) Total_sales
	FROM Gold.fact_sales S 
		LEFT JOIN Gold.dim_product P
	ON S.product_key = P.product_key
		GROUP BY P.category
)

SELECT 
*,
SUM(Total_sales) OVER() Overall_sales,
CONCAT(ROUND((CAST(Total_sales AS float)/SUM(Total_sales) OVER()) * 100,2),'%') Percentage_contribution
FROM Category_sales
ORDER BY Total_sales DESC
