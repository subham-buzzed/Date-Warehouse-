
CREATE OR ALTER PROCEDURE Silver.Load_Script AS
BEGIN
	DECLARE @START_TIME DATETIME, @END_TIME DATETIME,@BATCH_START_TIME DATETIME, @BATCH_END_TIME DATETIME;
	--===================================================================
	BEGIN TRY

		SET @BATCH_START_TIME = GETDATE()
		SET @START_TIME = GETDATE();

		PRINT' '
		PRINT 'Truncating Silver.crm_cust_info ';

		TRUNCATE TABLE Silver.crm_cust_info

		PRINT 'Inserting Data into -> Silver.crm_cust_info ';

		INSERT INTO Silver.crm_cust_info
		(
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		)
		SELECT 
			cst_id,
			cst_key,
			TRIM(cst_firstname) cst_firstname,
			TRIM(cst_lastname) cst_lastname,
			CASE 
				WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
				WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN  'Married'
				ELSE 'N/A'
			END cst_marital_status,
			CASE 
				WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
				WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
				ELSE 'N/A'
			END cst_gndr,
			cst_create_date

		FROM 
			(SELECT
				*,
				ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) CHECKS
			FROM Bronze.crm_cust_info
				WHERE cst_id IS NOT NULL )T
		 WHERE CHECKS = 1  

		SET @END_TIME = GETDATE();
		PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds';

		 --===============================================================================
		 SET @START_TIME = GETDATE();

		 PRINT' ';
		 PRINT'Truncating  Silver.crm_prd_info';

		 TRUNCATE TABLE Silver.crm_prd_info

		 PRINT'Inserting Data into -> Silver.crm_prd_info';

		 INSERT INTO Silver.crm_prd_info
		(
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
		)
		SELECT 
			prd_id,
			REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
			SUBSTRING(prd_key,7,LEN(prd_key)) prd_key,
			TRIM(prd_nm) prd_nm,
			ISNULL(prd_cost,0) prd_cost,
			CASE TRIM(prd_line)
				WHEN 'M' THEN 'Mountain'
				WHEN 'R' THEN 'Road'
				WHEN 'T' THEN 'Touring'
				WHEN 'S' THEN 'Other Sales'
				ELSE 'N/A'
			END prd_line,
			CAST(prd_start_dt AS DATE) prd_start_dt,
			CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt )-1 AS DATE)  prd_end_dt
		FROM Bronze.crm_prd_info

		SET @END_TIME = GETDATE()
		PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds';

		--======================================================================================

		SET @START_TIME = GETDATE();

		PRINT' '
		PRINT'Truncating Silver.crm_sales_details';

		TRUNCATE TABLE Silver.crm_sales_details

		PRINT'Inserting Data into -> Silver.crm_sales_details';

		INSERT INTO Silver.crm_sales_details
		(
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price
		)
		SELECT 
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE
				WHEN LEN(sls_order_dt) != 8 OR sls_order_dt <= 0 
					OR sls_order_dt < 19000101 OR sls_order_dt > 20501231
				THEN NULL
				ELSE CAST(CAST(sls_order_dt AS varchar)AS date)
			END sls_order_dt,

			CASE
				WHEN LEN(sls_ship_dt) != 8 OR sls_ship_dt <= 0 
					OR sls_ship_dt < 19000101 OR sls_ship_dt > 20501231
				THEN NULL
				ELSE CAST(CAST(sls_ship_dt AS varchar)AS date)
			END sls_ship_dt,

			CASE
				WHEN LEN(sls_due_dt) != 8 OR sls_due_dt <= 0 
					OR sls_due_dt < 19000101 OR sls_due_dt > 20501231
				THEN NULL
				ELSE CAST(CAST(sls_due_dt AS varchar)AS date)
			END sls_due_dt,

			CASE 
				WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
					THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
			END sls_sales,

			sls_quantity,

			CASE 
				WHEN sls_price IS NULL OR sls_price <= 0 
					THEN sls_sales/NULLIF(sls_quantity,0)
				ELSE sls_price
			END sls_price
		FROM Bronze.crm_sales_details

		SET @END_TIME = GETDATE()
		PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds';

		--==================================================================================

		SET @START_TIME = GETDATE();

		PRINT' '
		PRINT'Truncating Silver.erp_cust_az12';

		TRUNCATE TABLE Silver.erp_cust_az12

		PRINT'Inserting Data into -> Silver.erp_cust_az12';


		INSERT INTO Silver.erp_cust_az12
		(
			cid,
			bdate,
			gen
		)

		SELECT 
			CASE 
				WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
				ELSE cid
			END cid,

		
			CASE 
				WHEN bdate > GETDATE() THEN NULL
				ELSE bdate
			END bdate,

			CASE 
				WHEN gen = 'F' THEN 'Female'
				WHEN gen = 'M' THEN 'Male'
				WHEN gen IS NULL OR gen = ' ' THEN 'N/A'
		
				ELSE gen
			END gen
		FROM Bronze.erp_cust_az12

		SET @END_TIME = GETDATE()
		PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds';

		--=========================================================================
		
		SET @START_TIME = GETDATE();

		PRINT' ';
		PRINT'Truncating Silver.erp_loc_a101';

		TRUNCATE TABLE  Silver.erp_loc_a101

		PRINT'Inserting Data into -> Silver.erp_loc_a101';

		INSERT INTO Silver.erp_loc_a101
			(
				cid,
				cntry
			)
		SELECT 
			REPLACE (cid, '-','') cid,

			CASE 
				WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
				WHEN TRIM(cntry) IN ('DE') THEN 'Germany'
				WHEN TRIM(cntry) IS NULL OR TRIM(cntry) = ''  THEN 'N/A'
				ELSE cntry
			END cntry

		FROM Bronze.erp_loc_a101

		SET @END_TIME = GETDATE()
		PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds';

		--==========================================================================

		SET @START_TIME = GETDATE();

		PRINT' ';
		PRINT'Truncating Silver.erp_px_cat_g1v2';

		TRUNCATE TABLE Silver.erp_px_cat_g1v2

		PRINT'Inserting Data into -> Silver.erp_px_cat_g1v2';

		INSERT INTO Silver.erp_px_cat_g1v2
		(
			id,
			cat,
			subcat,
			maintenance
		)
		SELECT 
			id,
			cat,
			subcat,
			maintenance
		FROM Bronze.erp_px_cat_g1v2

		SET @END_TIME = GETDATE()
		PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds';

		SET @BATCH_END_TIME = GETDATE()
		PRINT'ALL Data is transferd '+ CAST(DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME) AS NVARCHAR)+' seconds'
		PRINT 'ALL THE  FILES ARE Transfered from Bronze to Silver'
		END TRY

		BEGIN CATCH
			PRINT'ERROR OCUURED';
			PRINT 'ERROR IS:'+ ERROR_MESSAGE();
		END CATCH
END
