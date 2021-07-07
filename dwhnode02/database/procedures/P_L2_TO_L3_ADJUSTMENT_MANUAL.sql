--
-- P_L2_TO_L3_ADJUSTMENT_MANUAL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L2_TO_L3_ADJUSTMENT_MANUAL (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VL2STATUS NUMBER;
    VL3STATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN

        SELECT DATE_KEY INTO VDATE_KEY 
        FROM DATE_DIM@DWH05TODWH01
        WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);
        
        INSERT INTO L3_ADJUSTMENT
        SELECT /*+ PARALLEL(L2_ADJUSTMENT,16) */
        ETL_DATE_KEY                   ,
        A5_PRI_IDENTITY                ,
        A6_PAY_TYPE                    ,
        A8_CHANNEL_ID                  ,
        A9_REASON_CODE                 ,
        A11_ERROR_TYPE                 ,
        SUM(A13_ADJUST_AMT )              ,
        A17_ACCESS_METHOD              ,
        A21_STATUS                     ,
        A22_ENTRY_DATE_KEY             ,
        A22_ENTRY_DATE_HOUR            ,
        A28_REGION_ID                  ,
        SUM(A30_DEBIT_AMOUNT)               ,
        A31_RESERVED                   ,
        SUM(A32_DEBIT_FROM_PREPAID)     ,
        SUM(A33_DEBIT_FROM_ADVANCE_PREPAID)  ,
        SUM(A34_DEBIT_FROM_POSTPAID)        ,
        SUM(A37_TOTAL_TAX)                  ,
        SUM(A38_FREE_UNIT_AMOUNT_OF_TIMES)  ,
        SUM(A39_PAY_FREE_UNIT_DURATION)     ,
        SUM(A40_FREE_UNIT_AMOUNT_OF_FLUX )  ,
        SUM(A44_CUR_BALANCE )               ,
        A50_OPER_TYPE                  ,
        A141_FU_OWN_TYPE               ,
        A150_FU_MEASURE_ID             ,
        A368_PRE_APPLY_TIME_KEY        ,
        A368_PRE_APPLY_HOUR            ,
        A461_BRANDID                   ,
        A462_MAINOFFERINGID            ,
        A463_PAYTYPE                   ,
        A469_USERSTATE                 ,
        A470_OLDUSERSTATE              ,
        SUM(A491_TAX_AMOUNT )              ,
        A498_TAX_PRICE_FLAG 
        FROM L2_ADJUSTMENT@DWH05TODWH01           
        WHERE ETL_DATE_KEY= VDATE_KEY
        GROUP BY 
        ETL_DATE_KEY                   ,
        A5_PRI_IDENTITY                ,
        A6_PAY_TYPE                    ,
        A8_CHANNEL_ID                  ,
        A9_REASON_CODE                 ,
        A11_ERROR_TYPE                 ,
        A17_ACCESS_METHOD              ,
        A21_STATUS                     ,
        A22_ENTRY_DATE_KEY             ,
        A22_ENTRY_DATE_HOUR            ,
        A28_REGION_ID                  ,
        A31_RESERVED                   ,
        A50_OPER_TYPE                  ,
        A141_FU_OWN_TYPE               ,
        A150_FU_MEASURE_ID             ,
        A368_PRE_APPLY_TIME_KEY        ,
        A368_PRE_APPLY_HOUR            ,
        A461_BRANDID                   ,
        A462_MAINOFFERINGID            ,
        A463_PAYTYPE                   ,
        A469_USERSTATE                 ,
        A470_OLDUSERSTATE              ,
        A498_TAX_PRICE_FLAG;
        COMMIT;
        INSERT INTO ETL_LOG@DWH05TODWH01 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L3_ADJUSTMENT',VDATE_KEY,'adj','96','','','',SYSDATE);
        commit;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

