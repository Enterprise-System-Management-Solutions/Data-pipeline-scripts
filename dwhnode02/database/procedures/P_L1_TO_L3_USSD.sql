--
-- P_L1_TO_L3_USSD  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L3_USSD (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS2 NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT COUNT(*) INTO VCOUNT 
    FROM CDR_HEAD@DWH05TODWH03
    WHERE SOURCE = 'ussd'
    AND PROCESS_STATUS = 96
    AND TRUNC(PROCESS_DATE) = TRUNC(VDATE);
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT DATE_KEY FROM DATE_DIM WHERE TRUNC(DATE_VALUE) = TRUNC(VDATE));
    
  IF VCOUNT > 0  THEN
      INSERT INTO ETL_LOG@DWH05TODWH03 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
      VALUES              ('L1_USSD',VDATE_KEY,'ussd','96',VCOUNT,'','',SYSDATE);
      COMMIT;
       

    
    SELECT COUNT(STATUS) INTO VSTATUS2
    FROM ETL_LOG@DWH05TODWH03
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE TRUNC(DATE_VALUE) = TRUNC(VDATE))
    AND LAYER = 'L3_USSD'
    AND SOURCE = 'ussd';   
    
    IF  VSTATUS2=0 THEN
        INSERT INTO ETL_LOG@DWH05TODWH03 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L3_USSD',VDATE_KEY,'ussd','30',VCOUNT,'','',SYSDATE);
        COMMIT;
        INSERT INTO L3_USSD
        SELECT 
        B.DATE_KEY                ,
        USSD1_RECTYPE                 ,
        USSD2_BILLID                  ,
        USSD3_CALLERTYPE              ,
        USSD4_ISPPSUSER               ,
        USSD5_MSISDN                  ,
        USSD6_SERVICECODE             ,
        USSD7_SERVICETYPE             ,
        USSD8_USSDCID                 ,
        USSD9_BILLTYPE                ,
        C.DATE_KEY USSD10_CALLBEGINTIME          ,
        USSD11_CALLENDTIME            ,
        USSD12_CALLINFOSIZE           ,
        USSD13_CALLTIME               ,
        USSD14_CALLFEE                ,
        USSD15_CALLINTERACTIVECOUNT   ,
        USSD16_CALLMSREQUESTCOUNT     ,
        USSD17_CALLSERVICEREQUESTCOUNT,
        USSD18_CALLSERVICENOTIFYCOUNT ,
        USSD19_CALLRELEASESTATUS      ,
        USSD20_CHARGEINDEX            ,
        USSD21_CHARGEINFOFEE          ,
        USSD22_CHARGETYPE             ,
        USSD23_CHARGESPCODE           ,
        USSD24_CHARGEOPERCODE         ,
        USSD25_IMSI                   ,
        USSD26_IMEI                   ,
        USSD27_RESERVED               ,
        USSD28_ACCOUNTNAME            ,
        USSD29_ERRORCODE              ,
        USSD30_MVNOID                 ,
        USSD31_LAC                    ,
        USSD32_CELLID                 ,
        USSD33_MSC                    ,
        USSD34_USERINPUTFLOW          ,
        USSD35_SESSIONINITTYPE        ,
        USSD36_SESSIONINITTYPEDESC    ,
        USSD37_PSSRCONTENT            ,
        USSD38_LASTUSERINPUT          ,
        USSD39_LASTSPCONTENT
        FROM L1_USSD@DWH05TODWH03 A, DATE_DIM B, DATE_DIM C
        WHERE trunc(A.PROCESSED_DATE)= trunc(VDATE)
        AND TO_CHAR(B.DATE_VALUE,'RRRRMMDD')=TO_CHAR(A.PROCESSED_DATE,'RRRRMMDD')
        AND TO_CHAR(C.DATE_VALUE,'RRRR-MM-DD')=SUBSTR(A.USSD10_CALLBEGINTIME,1,10)
        AND A.USSD1_RECTYPE ='20';
        COMMIT;
    UPDATE ETL_LOG@DWH05TODWH03 SET STATUS = 96,
    UPDATE_TIME=SYSDATE
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L3_USSD';        
    COMMIT;
    END IF;
  ELSE
     INSERT INTO ETL_LOG@DWH05TODWH03 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
     VALUES              ('L3_USSD',VDATE_KEY,'ussd','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

