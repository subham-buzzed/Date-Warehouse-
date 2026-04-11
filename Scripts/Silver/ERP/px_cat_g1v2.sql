IF OBJECT_ID('Silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE Silver.erp_px_cat_g1v2;
GO

CREATE TABLE Silver.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO
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
