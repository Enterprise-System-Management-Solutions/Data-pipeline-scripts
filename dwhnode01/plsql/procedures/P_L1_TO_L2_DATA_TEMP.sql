--
-- P_L1_TO_L2_DATA_TEMP  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_DATA_TEMP (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VSTATUS2 NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');--TO_CHAR(TO_DATE(P_PROCESS_DATE,'RRRRMMDD'), 'DD/MM/RRRR');
BEGIN
    SELECT COUNT(*) INTO VCOUNT 
    FROM CDR_HEAD_MERGE
    WHERE SOURCE = 'data'
    AND PROCESS_STATUS = 96
    AND TO_DATE(PROCESS_DATE,'DD/MM/RRRR') = VDATE;--TO_DATE(SYSDATE-7,'DD/MM/RRRR');
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);
    
  IF VCOUNT >= 1  THEN
      INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
      VALUES              ('L1_DATA',VDATE_KEY,'data','96',VCOUNT,'','',SYSDATE);
      COMMIT;
        
    SELECT STATUS INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE-1)
    AND LAYER = 'L2_DATA'
    AND SOURCE = 'data';    
    
    SELECT STATUS INTO VSTATUS2
    FROM TEMP_TABLE_ALTER_LOG
    WHERE trunc(ALTER_DATE) = trunc(sysdate)
    AND TABLE_NAME = 'L1_DATA_TEMP'; 
    
    IF VSTATUS = 96 and VSTATUS2= 96 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_DATA',VDATE_KEY,'data','30',VCOUNT,'','',SYSDATE);
        COMMIT;

        INSERT INTO L2_DATA
        SELECT /*+ PARALLEL(A,16) */
        C.DATE_KEY AS ETL_DATE_KEY,
        A.FILE_NAME,
        NVL(G41_DEBIT_AMOUNT,0) / 1000000 ,
        G51_FREE_UNIT_AMOUNT_OF_FLUX,
        G372_CALLINGPARTYNUMBER     ,
        G375_CALLINGPARTYIMSI       ,
        G379_CALLINGCELLID              ,
        B.DATE_KEY AS  G383_CHARGINGTIME_KEY       ,
        TO_CHAR(TO_DATE( SUBSTR(G383_CHARGINGTIME,9,4), 'HH24MI')+360/1440, 'HH24MI') AS  G383_CHARGINGTIME_HOUR,--SUBSTR(G383_CHARGINGTIME,9,4) AS  G383_CHARGINGTIME_HOUR     ,
        G384_TOTALFLUX                            ,
        G388_IMEI                                 ,
        G389_SERVICEID                            ,
        G401_MAINOFFERINGID                       ,
        G403_PAYTYPE                              ,
        G404_CHARGINGTYPE                         ,
        G412_SERVICETYPE                          ,
        G418_LASTEFFECTOFFERING                    ,
        G429_RATTYPE                              ,
        G430_CHARGEPARTYINDICATOR                 ,
        NVL(G432_PRIMARYOFFERCHGAMT,0) / 1000000  ,
        G435_TAXINFO                              ,
        G446_PAY_FREE_UNIT_FLUX                   ,
        G447_PAY_FREE_UNIT_DURATION               ,
        NVL(G448_PAY_DEBIT_AMOUNT,0) / 1000000    ,
        NVL(G449_PAY_DEBIT_FROM_PREPAID,0) / 1000000 ,
        NVL(G450_PAY_PREPAID_BALANCE,0) / 1000000 ,
        NVL(G453_PAY_POSTPAID_BALANCE,0) / 1000000,
        G455_SUBSCRIBERIDTYPE                     ,
        G467_ACCUMLATEDPOINT
        FROM  L1_DATA_TEMP_FULL A,DATE_DIM B,DATE_DIM C
        WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(A.G383_CHARGINGTIME,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(B.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(A.G383_CHARGINGTIME,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
        AND TRUNC(C.DATE_VALUE)=TRUNC(SYSDATE-1);
        COMMIT;
    UPDATE ETL_LOG SET STATUS = 96,
    UPDATE_TIME=SYSDATE
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L2_DATA';
        COMMIT;
    END IF;
  ELSE
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_DATA',VDATE_KEY,'data','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/
