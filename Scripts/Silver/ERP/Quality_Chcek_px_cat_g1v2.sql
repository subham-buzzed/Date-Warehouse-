--== DATA QUALITY CHECK FOR px_cat_g1v2

--  CHECKING UNWANTED SPACE 
SELECT * FROM Bronze.erp_px_cat_g1v2
 WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

-- DATA STANDARDIZATION & CONSISTENCY

 SELECT DISTINCT cat
 FROM Bronze.erp_px_cat_g1v2

 SELECT DISTINCT subcat
 FROM Bronze.erp_px_cat_g1v2

 SELECT DISTINCT maintenance
 FROM Bronze.erp_px_cat_g1v2
