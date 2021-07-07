--
-- P_L2_TO_L3_TRANSFER_MANUAL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L2_TO_L3_TRANSFER_MANUAL (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VL2STATUS NUMBER;
    VL3STATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT DATE_KEY INTO VDATE_KEY 
    FROM DATE_DIM@DWH05TODWH01
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);--(SELECT A.DATE_KEY FROM DATE_DIM A WHERE TO_DATE(A.DATE_VALUE,'DD/MM/YYYY') = TO_DATE(SYSDATE,'DD/MM/YYYY'));

        INSERT INTO L3_TRANSFER
        SELECT /*+ PARALLEL(L2_TRANSFER,16) */
        ETL_DATE_KEY        ,
        T4_CUST_ID                ,
        T6_PRI_IDENTITY           ,
        T9_REASON_CODE            ,
        T10_RESULT_CODE           ,
        T11_ERROR_TYPE            ,
        T15_TRANSFER_TYPE         ,
        SUM(T16_TRANSFER_AMT)          ,
        T17_TRANSFER_DATE_KEY     ,
        T17_TRANSFER_DATE_HOUR    ,
        T18_TRANSFER_TRANS_ID     ,
        T22_DIAMETER_SESSIONID    ,
        T24_REVERSAL_TRANS_ID     ,
        T25_REVERSAL_REASON_CODE  ,
        T28_STATUS                ,
        T29_ENTRY_DATE_KEY        ,
        T29_ENTRY_DATE_HOUR       ,
        T39_BALANCE_TYPE          ,
        SUM(T40_CUR_BALANCE)           ,
        SUM(T41_CHG_BALANCE)          ,
        T46_OPER_TYPE             ,
        T458_MAINOFFERINGID       ,
        T459_PAYTYPE              ,
        T477_OTHERNUMBER          ,
        SUM(T480_PREPAID_BALANCE)      ,
        SUM(T481_POSTPAID_BALANCE)    ,
        T489_CHARGE_OF_FUND  
        FROM L2_TRANSFER@DWH05TODWH01
        WHERE ETL_DATE_KEY= VDATE_KEY
        GROUP BY 
        ETL_DATE_KEY , 
        T4_CUST_ID                ,
        T6_PRI_IDENTITY           ,
        T9_REASON_CODE            ,
        T10_RESULT_CODE           ,
        T11_ERROR_TYPE            ,
        T15_TRANSFER_TYPE         ,
        T17_TRANSFER_DATE_KEY     ,
        T17_TRANSFER_DATE_HOUR    ,
        T18_TRANSFER_TRANS_ID     ,
        T22_DIAMETER_SESSIONID    ,
        T24_REVERSAL_TRANS_ID     ,
        T25_REVERSAL_REASON_CODE  ,
        T28_STATUS                ,
        T29_ENTRY_DATE_KEY        ,
        T29_ENTRY_DATE_HOUR       ,
        T39_BALANCE_TYPE          ,
        T46_OPER_TYPE             ,
        T458_MAINOFFERINGID       ,
        T459_PAYTYPE              ,
        T477_OTHERNUMBER          ,
        T489_CHARGE_OF_FUND  ;
        COMMIT;
        INSERT INTO ETL_LOG@DWH05TODWH01 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L3_TRANSFER',VDATE_KEY,'transfer','96','','','',SYSDATE);
        COMMIT;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

