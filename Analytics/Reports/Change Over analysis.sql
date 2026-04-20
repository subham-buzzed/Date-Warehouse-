/**
  
  THIS REPORTS  HELPS TO GENERATE INSIGHTS ABOUT
                        - Yealy Sales <-> C1
                        - Total sales Change in each month in each year <-> C2

THAT CAN BE USED FOR EFFECTIVE ANALYTICAL DASHBOARD / ADVANCE ANALYSIS

========================================================================================
      ** JUST TO USE WHERE CLAUSE FOR SPECIFIC TIMESPAN **
*/

--========== CHANGE OVER YEARS ============
-- C1
SELECT 
	DATENAME(YEAR,order_date) Years,
	SUM(sales) Total_sales,
	SUM(quantity) Total_quantity,
	COUNT(DISTINCT customer_key) Total_customer
FROM GOLD.fact_sales
WHERE order_date IS NOT NULL
	GROUP BY DATENAME(YEAR,order_date)
	ORDER BY DATENAME(YEAR,order_date)

--=========== CHANGE OVER MONTHS ========
--== Targets the months that has highest sales and customers =====
  -- C2

SELECT 
	FORMAT(Dates,'yyyy-MMM') Dates,
	Total_Sales,
	Total_quantity,
	Total_customer
FROM 
(
	SELECT 
	DATETRUNC(MONTH,order_date) Dates,
	SUM(sales) Total_Sales,
	SUM(quantity) Total_quantity,
	COUNT(DISTINCT customer_key) Total_customer
FROM Gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH,order_date)
)T
--WHERE YEAR(Dates) = 
