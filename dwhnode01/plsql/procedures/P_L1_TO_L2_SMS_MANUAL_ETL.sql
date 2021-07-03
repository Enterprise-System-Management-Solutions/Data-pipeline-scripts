--
-- P_L1_TO_L2_SMS_MANUAL_ETL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_SMS_MANUAL_ETL(P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VSTATUS2 NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT COUNT(*) INTO VCOUNT 
    FROM CDR_HEAD_MERGE
    WHERE SOURCE = 'sms'
    AND PROCESS_STATUS = 96
    AND TO_DATE(PROCESS_DATE,'DD/MM/RRRR') = VDATE;
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-1);
    
  IF VCOUNT >= 1  THEN
      INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
    VALUES              ('L1_SMS',VDATE_KEY,'sms','96',VCOUNT,'','',SYSDATE);
        
    SELECT STATUS INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-2)
    AND LAYER = 'L2_SMS'
    AND SOURCE = 'sms'; 
    
    SELECT COUNT(STATUS) INTO VSTATUS2
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-1)
    AND LAYER = 'L2_SMS'
    AND SOURCE = 'sms';  
    
    IF VSTATUS = 96 AND VSTATUS2=0 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_SMS',VDATE_KEY,'sms','30',VCOUNT,'','',SYSDATE);
        INSERT INTO L2_SMS
        SELECT /*+ PARALLEL(A,8) */
        C.DATE_KEY-1 AS ETL_DATE_KEY                    ,
        A.FILE_NAME                      ,
        S4_SPLIT_CDR_REASON            ,
        S9_STATUS                      ,
        S18_OBJ_TYPE                   ,
        S22_PRI_IDENTITY               ,
        S24_SERVICE_CATEGORY           ,
        NVL(S41_DEBIT_AMOUNT,0) / 1000000 AS S41_DEBIT_AMOUNT,
        S372_CALLINGPARTYNUMBER        ,
        S373_CALLEDPARTYNUMBER         ,
        S374_CALLINGPARTYIMSI          ,
        S378_SERVICEFLOW               ,
        S379_CALLFORWARDINDICATOR      ,
        S381_CALLINGCELLID             ,
        B.DATE_KEY AS S387_CHARGINGTIME_KEY          ,
        TO_CHAR(TO_DATE( SUBSTR(S387_CHARGINGTIME,9,4), 'HH24MI')+360/1440, 'HH24MI') AS  S387_CHARGINGTIME_HOUR,--SUBSTR(S387_CHARGINGTIME,9,4) AS S387_CHARGINGTIME_HOUR         ,
        S388_SENDRESULT                ,
        S391_SMLENGTH                  ,
        S393_REFUNDINDICATOR           ,
        S395_MAINOFFERINGID            ,
        S397_CHARGEPARTYINDICATOR      ,
        S398_PAYTYPE                   ,
        S400_SMSTYPE                   ,
        S401_ONNETINDICATOR            ,
        S416_SPECIALNUMBERINDICATOR    ,
        S417_NPFLAG                    ,
        S418_NPPREFIX                  ,
        S434_LASTEFFECTOFFERING        ,
        S438_SPECIALZONEID             ,
        S445_PRIMARYOFFERCHGAMT        ,
        S448_TAXINFO                   ,
        S456_DISCOUNTOFLASTEFFOFFERING ,
        S457_UNROUND                   ,
        NVL(S459_PREPAID_BALANCE,0) / 1000000 AS S459_PREPAID_BALANCE,
        NVL(S460_POSTPAID_BALANCE,0) / 1000000 AS S460_POSTPAID_BALANCE,
        S479_RATED_OFFER_ID ,
        S25_USAGE_SERVICE_TYPE  ,
        S402_ROAMSTATE      
        FROM L1_SMS A,DATE_DIM B,DATE_DIM C
        WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(A.S387_CHARGINGTIME,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(B.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(A.S387_CHARGINGTIME,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
        AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(A.PROCESSED_DATE, 'DD/MM/YYYY') 
        AND TO_DATE(A.PROCESSED_DATE,'DD/MM/RRRR') = VDATE;
         COMMIT;
    UPDATE ETL_LOG SET STATUS = 96 
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L2_SMS';        
        COMMIT;
    END IF;
  ELSE
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_SMS',VDATE_KEY,'sms','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/
