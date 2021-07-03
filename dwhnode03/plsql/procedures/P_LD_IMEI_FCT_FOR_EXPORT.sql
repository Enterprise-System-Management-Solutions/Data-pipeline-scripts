--
-- P_LD_IMEI_FCT_FOR_EXPORT  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER03.P_LD_IMEI_FCT_FOR_EXPORT IS

BEGIN

EXECUTE IMMEDIATE 'TRUNCATE TABLE LD_IMEI_FCT DROP STORAGE';

INSERT INTO LD_IMEI_FCT
SELECT /*+ parallel(A,16)*/ MSISDN,IMEI,IMSI
FROM IMEI_FCT A
WHERE DATE_KEY IN (SELECT DATE_KEY FROM DATE_DIM WHERE TO_DATE(DATE_VALUE,'dd/mm/rrrr') BETWEEN TO_DATE('14/06/2021','dd/mm/rrrr') AND TO_DATE('01/07/2021','dd/mm/rrrr'))
AND IMEI != '10'
AND IMEI IS NOT NULL
AND MSISDN  IS NOT NULL
AND IMSI IS NOT NULL
GROUP BY MSISDN,IMEI,IMSI;
COMMIT;
END;
/

