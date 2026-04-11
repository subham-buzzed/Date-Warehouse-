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
