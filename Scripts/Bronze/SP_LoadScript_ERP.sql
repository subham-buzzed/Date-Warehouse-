--=== STORED PROCEDURE FOR DATA LOADING OF ERP_FILES

CREATE OR ALTER PROCEDURE Bronze.load_bronze_erp AS 
	BEGIN
		DECLARE @START_TIME DATETIME, @END_TIME DATETIME
-- ===== LOAD SCRIPT FOR ERP-CUST-az12 =========
		BEGIN TRY
			SET @START_TIME = GETDATE();
				PRINT'Inserting Data info: ERP-CUST-az12';

					TRUNCATE TABLE  Bronze.erp_cust_az12;

					BULK INSERT Bronze.erp_cust_az12
					FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_erp/CUST_AZ12.csv'
					WITH 
					(
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						TABLOCK
					);

				SET @END_TIME = GETDATE()
				PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds'
				PRINT'======================================================================='

	-- ========== LOAD SCRIPT FOR ERP-LOC-A101 ===========
				SET @START_TIME = GETDATE();
					PRINT'Inserting Data info: ERP_LOC_A101';

					TRUNCATE TABLE  Bronze.erp_loc_a101;
		
					BULK INSERT Bronze.erp_loc_a101
					FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_erp/CUST_AZ12.csv'
					WITH 
					(
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						TABLOCK
					);

				SET @END_TIME = GETDATE()
				PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' seconds'
				PRINT'======================================================================='


--============ LOAD SCRIPT FOR ERP-PX-CAT-G1V2 =======
				SET @START_TIME = GETDATE();
					PRINT'Inserting Data info: ERP-PX-CAT-G1V2';

					TRUNCATE TABLE  Bronze.erp_px_cat_g1v2;
		
					BULK INSERT Bronze.erp_px_cat_g1v2
					FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
					WITH 
					(
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						TABLOCK
					);

				SET @END_TIME = GETDATE()
				PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' seconds'
				PRINT'======================================================================='

				PRINT 'ALL THE ERP FILES ARE LOADED'

		END TRY
		BEGIN CATCH
			PRINT'ERROR OCUURED'
			PRINT 'ERROR IS:'+ ERROR_MESSAGE()
		END CATCH
	END 
