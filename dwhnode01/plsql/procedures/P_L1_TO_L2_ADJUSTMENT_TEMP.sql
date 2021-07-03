--
-- P_L1_TO_L2_ADJUSTMENT_TEMP  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_ADJUSTMENT_TEMP (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VSTATUS2 NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT COUNT(*) INTO VCOUNT 
    FROM CDR_HEAD_MERGE
    WHERE SOURCE = 'adj'
    AND PROCESS_STATUS = 96
    AND TO_DATE(PROCESS_DATE,'DD/MM/RRRR') = VDATE;
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);
    
  IF VCOUNT >= 1  THEN
      INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
      VALUES              ('L1_ADJUSTMENT',VDATE_KEY,'adj','96',VCOUNT,'','',SYSDATE);
      COMMIT;
       
    SELECT STATUS INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-1)
    AND LAYER = 'L2_ADJUSTMENT'
    AND SOURCE = 'adj';  
    
    SELECT STATUS INTO VSTATUS2
    FROM TEMP_TABLE_ALTER_LOG
    WHERE trunc(ALTER_DATE) = trunc(sysdate)
    AND TABLE_NAME = 'L1_ADJUSTMENT_TEMP'; 
    
    IF VSTATUS = 96 and VSTATUS2= 96 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_ADJUSTMENT',VDATE_KEY,'adj','30',VCOUNT,'','',SYSDATE);
        COMMIT;
        INSERT INTO L2_ADJUSTMENT
        SELECT /*+ PARALLEL(S,8) */
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
        TO_CHAR(TO_DATE( SUBSTR(A22_ENTRY_DATE,9,4), 'HH24MI')+360/1440, 'HH24MI') AS A22_ENTRY_DATE_HOUR,--SUBSTR(A22_ENTRY_DATE,9,4) AS A22_ENTRY_DATE_HOUR, 
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
        NVL(A44_CUR_BALANCE,0) / 1000000,
        A50_OPER_TYPE, 
        A141_FU_OWN_TYPE, 
        A150_FU_MEASURE_ID, 
        A368_PRE_APPLY_TIME,--E.DATE_KEY AS A368_PRE_APPLY_TIME, 
        A368_PRE_APPLY_TIME,--SUBSTR(A368_PRE_APPLY_TIME,9,4) AS A368_PRE_APPLY_HOUR, 
        A461_BRANDID, 
        A462_MAINOFFERINGID, 
        A463_PAYTYPE, 
        A469_USERSTATE, 
        A470_OLDUSERSTATE, 
        NVL(A491_TAX_AMOUNT,0) / 1000000, 
        A498_TAX_PRICE_FLAG        
        FROM  L1_ADJUSTMENT_TEMP_FULL S,DATE_DIM B,DATE_DIM C
        WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(S.A22_ENTRY_DATE,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(B.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(S.A22_ENTRY_DATE,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
        AND TRUNC(C.DATE_VALUE)=TRUNC(SYSDATE-1);
        COMMIT;
    UPDATE ETL_LOG SET STATUS = 96,
    UPDATE_TIME=SYSDATE
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L2_ADJUSTMENT';        
        COMMIT;
    END IF;
  ELSE
     INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
     VALUES              ('L2_ADJUSTMENT',VDATE_KEY,'adj','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

