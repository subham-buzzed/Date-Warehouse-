--=== STORED PROCEDURE FOR DATA LOADING OF CRM_FILES

CREATE OR ALTER PROCEDURE Bronze.load_bronze_crm AS 
	BEGIN

	-- ===== LOAD SCRIPT FOR CRM-CUST-INFO =========

		TRUNCATE TABLE  Bronze.crm_cust_info;
		
		BULK INSERT Bronze.crm_cust_info
		FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_crm/cust_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	-- ========== LOAD SCRIPT FOR CRM-PRD-INFO ===========

		TRUNCATE TABLE  Bronze.crm_prd_info;
		
		BULK INSERT Bronze.crm_prd_info
		FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_crm/prd_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		--============ LOAD SCRIPT FOR CRM-SALES-DETAILS =======

		TRUNCATE TABLE  Bronze.crm_sales_details;
		
		BULK INSERT Bronze.crm_sales_details
		FROM 'C:\DALAIs Document\SQL\DATA\Data Warehouse\sql-data-warehouse-project\datasets\source_crm/sales_details.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
	END 
