--
-- P_L1_TO_L2_RECHARGE_MANUAL_ETL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_RECHARGE_MANUAL_ETL (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VSTATUS2 NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT COUNT(*) INTO VCOUNT 
    FROM CDR_HEAD_MERGE
    WHERE SOURCE = 'vou'
    AND PROCESS_STATUS = 96
    AND TO_DATE(PROCESS_DATE,'DD/MM/RRRR') = VDATE;
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-1);
    
  IF VCOUNT >= 1  THEN
      INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
    VALUES              ('L1_RECHARGE',VDATE_KEY,'vou','96',VCOUNT,'','',SYSDATE);
        
    SELECT STATUS INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-2)
    AND LAYER = 'L2_RECHARGE'
    AND SOURCE = 'vou';    
    
    SELECT COUNT(STATUS) INTO VSTATUS2
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-1)
    AND LAYER = 'L2_RECHARGE'
    AND SOURCE = 'vou';    
    
    IF VSTATUS = 96 AND VSTATUS2 =0 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_RECHARGE',VDATE_KEY,'vou','30',VCOUNT,'','',SYSDATE);

        INSERT INTO L2_RECHARGE
        SELECT /*+ PARALLEL(A,8) */
        C.DATE_KEY-1 AS ETL_DATE_KEY,
        A.FILE_NAME,
        RE2_RECHARGE_CODE     ,
        NVL(RE3_RECHARGE_AMT,0) / 1000000 AS RE3_RECHARGE_AMT,
        RE4_ACCT_ID           ,
        RE5_SUB_ID            ,
        RE6_PRI_IDENTITY       ,
        nvl(RE9_ORIGINAL_AMT,0) / 1000000 as RE9_ORIGINAL_AMT,
        RE18_PAYMENT_TYPE     ,
        RE19_RECHARGE_TAX     ,
        RE21_RECHARGE_TYPE    ,
        RE22_CHANNEL_ID       ,
        RE24_RESULT_CODE      ,
        RE25_ERROR_TYPE       ,
        E.DATE_KEY AS RE30_ENTRY_DATE_KEY   , 
        TO_CHAR(TO_DATE( SUBSTR(RE30_ENTRY_DATE,9,4), 'HH24MI')+360/1440, 'HH24MI') AS  RE30_ENTRY_DATE_HOUR,--SUBSTR(RE30_ENTRY_DATE,9,4) AS  RE30_ENTRY_DATE_HOUR    ,   
        RE42_REGION_ID            ,  
        RE43_REGION_CODE          ,
        RE47_CARD_STATUS          ,
        NVL(RE50_CARD_AMOUNT,0) / 1000000 AS  RE50_CARD_AMOUNT,
        NVL(RE69_CUR_BALANCE,0) / 1000000 AS  RE69_CUR_BALANCE,
        RE166_FU_OWN_TYPE         ,
        NVL(RE170_CUR_AMOUNT,0) / 1000000 AS  RE170_CUR_AMOUNT,
        RE486_RECHARGEAREACODE    ,
        RE487_RECHARGECELLID      ,
        RE489_MAINOFFERINGID      ,
        RE490_PAYTYPE             ,
        RE501_AGENTNAME        
        FROM  L1_RECHARGE A,DATE_DIM E,DATE_DIM C
        WHERE TO_CHAR(E.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(A.RE30_ENTRY_DATE,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(E.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(A.RE30_ENTRY_DATE,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
        AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(A.PROCESSED_DATE, 'DD/MM/YYYY')
        AND TO_CHAR(A.PROCESSED_DATE,'YYYYMMDD') = P_PROCESS_DATE;
        COMMIT;
    UPDATE ETL_LOG SET STATUS = 96 
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L2_RECHARGE';        
        COMMIT;
    END IF;
  ELSE
    INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
    VALUES              ('L2_RECHARGE',VDATE_KEY,'vou','30',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

