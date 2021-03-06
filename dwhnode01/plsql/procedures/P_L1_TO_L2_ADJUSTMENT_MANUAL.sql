--
-- P_L1_TO_L2_ADJUSTMENT_MANUAL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_ADJUSTMENT_MANUAL (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN

    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);
    
        INSERT INTO L2_ADJUSTMENT
        SELECT /*+ PARALLEL(S,16) */
        C.DATE_KEY AS ETL_DATE_KEY, 
        S.FILE_NAME, 
        A5_PRI_IDENTITY, 
        A6_PAY_TYPE, 
        A8_CHANNEL_ID, 
        A9_REASON_CODE, 
        A11_ERROR_TYPE, 
        NVL(A13_ADJUST_AMT,0) / 1000000, 
        A17_ACCESS_METHOD, 
        A21_STATUS, 
        B.DATE_KEY AS A22_ENTRY_DATE_KEY, 
        TO_CHAR(TO_DATE( SUBSTR(A22_ENTRY_DATE,9,4), 'HH24MI')+360/1440, 'HH24MI') AS A22_ENTRY_DATE_HOUR, 
        A28_REGION_ID, 
        NVL(A30_DEBIT_AMOUNT,0) / 1000000, 
        A31_RESERVED, 
        NVL(A32_DEBIT_FROM_PREPAID,0) / 1000000, 
        NVL(A33_DEBIT_FROM_ADVANCE_PREPAID,0) / 1000000,
        NVL(A34_DEBIT_FROM_POSTPAID,0) / 1000000, 
        A37_TOTAL_TAX, 
        A38_FREE_UNIT_AMOUNT_OF_TIMES, 
        A39_PAY_FREE_UNIT_DURATION, 
        A40_FREE_UNIT_AMOUNT_OF_FLUX, 
        NVL(A44_CUR_BALANCE,0) / 1000000 , 
        A50_OPER_TYPE, 
        A141_FU_OWN_TYPE, 
        A150_FU_MEASURE_ID, 
        A368_PRE_APPLY_TIME,
        A368_PRE_APPLY_TIME,
        A461_BRANDID, 
        A462_MAINOFFERINGID, 
        A463_PAYTYPE, 
        A469_USERSTATE, 
        A470_OLDUSERSTATE, 
        NVL(A491_TAX_AMOUNT,0) / 1000000, 
        A498_TAX_PRICE_FLAG        
        FROM  L1_ADJUSTMENT S,DATE_DIM B,DATE_DIM C
        WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(S.A22_ENTRY_DATE,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--TO_DATE(TO_DATE( SUBSTR(A22_ENTRY_DATE,1,12), 'YYYYMMDD')+6/24, 'DD/MM/YYYY')
        AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(S.PROCESSED_DATE, 'DD/MM/YYYY')
        AND TO_DATE(S.PROCESSED_DATE,'DD/MM/RRRR') = VDATE;
        COMMIT;
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_ADJUSTMENT',VDATE_KEY,'adj','96',VCOUNT,'','',SYSDATE);
        COMMIT;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

