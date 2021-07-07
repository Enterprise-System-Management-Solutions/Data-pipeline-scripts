--
-- P_L2_TO_L3_ADJUSTMENT_ROW_COUNT  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L2_TO_L3_ADJUSTMENT_ROW_COUNT IS
BEGIN
        
        INSERT INTO L3_ADJUSTMENT_ROW_COUNT
        ---------------------------------
            SELECT /*+ PARALLEL(L2_ADJUSTMENT,8) */
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
            SUM(A491_TAX_AMOUNT )          ,
            A498_TAX_PRICE_FLAG,
            COUNT(ETL_DATE_KEY)
            FROM L2_ADJUSTMENT@DWH05TODWH01           
            WHERE ETL_DATE_KEY= (SELECT DATE_KEY FROM DATE_DIM WHERE TRUNC(DATE_VALUE)=TRUNC(SYSDATE-1))
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

END;
/

