--
-- MSISDN_COMPARE_7_2  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.MSISDN_COMPARE_7_2 IS
    VDATE_KEY        VARCHAR2(12);
BEGIN

    SELECT DATE_KEY INTO VDATE_KEY 
    FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = TO_DATE (SYSDATE-1,'dd/mm/rrrr'));
    
    DELETE /*+ PARALLEL(A,16) */  FROM MSISDN_FOR_SYSDATE_1_BASE A
    WHERE A.DATE_KEY=VDATE_KEY
    and ROWID > (SELECT /*+ PARALLEL(B,16) */ MIN(ROWID) FROM MSISDN_FOR_SYSDATE_1_BASE B
    WHERE B.DATE_KEY=VDATE_KEY
    AND B.MSISDN=A.MSISDN);
    COMMIT;

END;
/

