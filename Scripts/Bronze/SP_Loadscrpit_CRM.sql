--=== STORED PROCEDURE FOR DATA LOADING OF CRM_FILES

CREATE OR ALTER PROCEDURE Bronze.load_bronze_crm AS 
	BEGIN
		DECLARE @START_TIME DATETIME, @END_TIME DATETIME,@BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME
-- ===== LOAD SCRIPT FOR CRM-CUST-INFO =========
		BEGIN TRY
		 SET @BATCH_START_TIME = GETDATE()
			SET @START_TIME = GETDATE();
				PRINT'Inserting Data info: CRM-cust-info';

					TRUNCATE TABLE  Bronze.crm_cust_info;

					BULK INSERT Bronze.crm_cust_info
					FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_crm/cust_info.csv'
					WITH 
					(
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						TABLOCK
					);

				SET @END_TIME = GETDATE()
				PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME)AS NVARCHAR)+' seconds'
				PRINT'======================================================================='

	-- ========== LOAD SCRIPT FOR CRM-PRD-INFO ===========
				SET @START_TIME = GETDATE();
					PRINT'Inserting Data info: CRM-prd-info';

					TRUNCATE TABLE  Bronze.crm_prd_info;
		
					BULK INSERT Bronze.crm_prd_info
					FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_crm/prd_info.csv'
					WITH 
					(
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						TABLOCK
					);

				SET @END_TIME = GETDATE()
				PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' seconds'
				PRINT'======================================================================='


--============ LOAD SCRIPT FOR CRM-SALES-DETAILS =======
				SET @START_TIME = GETDATE();
					PRINT'Inserting Data info: CRM-sale-details';

					TRUNCATE TABLE  Bronze.crm_sales_details;
		
					BULK INSERT Bronze.crm_sales_details
					FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_crm/sales_details.csv'
					WITH 
					(
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						TABLOCK
					);

				SET @END_TIME = GETDATE()
				PRINT'Load time = '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' seconds'
				PRINT'======================================================================='
				SET @BATCH_END_TIME = GETDATE()
				PRINT'All CRM files are uploaded in '+ CAST(DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME) AS NVARCHAR)+' seconds'
				PRINT 'ALL THE CRM FILES ARE LOADED'

		END TRY
		BEGIN CATCH
			PRINT'ERROR OCUURED'
			PRINT 'ERROR IS:'+ ERROR_MESSAGE()
		END CATCH
	END 
