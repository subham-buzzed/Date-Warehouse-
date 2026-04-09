--====== FIELD cid CHCEKS

SELECT COUNT(*) FROM Bronze.erp_cust_az12
WHERE cid LIKE 'NAS%'

SELECT COUNT(*) FROM Bronze.erp_cust_az12
WHERE cid NOT LIKE 'NAS%'

--========= VALID DATE CHECKS
  
SELECT * FROM Bronze.erp_cust_az12
WHERE bdate > GETDATE()

--=== FIELD CHECKS : gen
  
SELECT DISTINCT gen FROM Bronze.erp_cust_az12
