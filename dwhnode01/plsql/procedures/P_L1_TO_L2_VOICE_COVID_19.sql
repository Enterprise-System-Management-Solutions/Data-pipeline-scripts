--
-- P_L1_TO_L2_VOICE_COVID_19  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_VOICE_COVID_19 IS

    VDATE VARCHAR2(14) := TO_CHAR(TO_DATE(SYSDATE,'DD/MM/RRRR'),'RRRRMMDD');
BEGIN

        EXECUTE IMMEDIATE  'TRUNCATE TABLE L2_VOICE_333 DROP STORAGE';
        
        INSERT INTO L2_VOICE_333
        SELECT /*+ PARALLEL(V,16) */
        C.DATE_KEY AS ETL_DATE_KEY,
        v.FILE_NAME,
        V24_SERVICE_CATEGORY            ,
        V25_USAGE_SERVICE_TYPE          ,
        V35_RATE_USAGE                  ,
        V36_SERVICE_UNIT_TYPE           ,
        NVL(V41_DEBIT_AMOUNT,0) / 1000000 AS V41_DEBIT_AMOUNT,
        NVL(V44_DEBIT_FROM_ADVANCE_PRE,0) / 1000000 AS V44_DEBIT_FROM_ADVANCE_PRE,
        V49_PAY_FREE_UNIT_TIMES         ,
        V50_PAY_FREE_UNIT_DURATION      ,
        NVL(V55_CUR_BALANCE,0) / 1000000 AS V55_CUR_BALANCE,
        V372_CALLINGPARTYNUMBER         ,
        V373_CALLEDPARTYNUMBER          ,
        V378_SERVICEFLOW                ,
        V380_CALLINGROAMINFO            ,
        V381_CALLINGCELLID              ,
        V383_CALLEDCELLID       ,        
        V386_BEARERCAPABILITY           ,
        B.DATE_KEY AS V387_CHARGINGTIME_KEY           , -- convert to key
        TO_CHAR(TO_DATE( SUBSTR(V387_CHARGINGTIME,9,4), 'HH24MI')+360/1440, 'HH24MI') AS  V387_CHARGINGTIME_HOUR,--SUBSTR(V387_CHARGINGTIME,9,4) AS  V387_CHARGINGTIME_HOUR ,-- NEW
        V389_TERMINATIONREASON          ,
        V391_IMEI                       ,
        V394_REDIRECTINGPARTYID         ,
        V395_MSCADDRESS                 ,
        V397_MAINOFFERINGID             ,
        V400_PAYTYPE                    ,
        V403_ROAMSTATE                  ,
        V405_CALLINGHOMEAREANUMBER      ,
        V417_HOTLINEINDICATOR,
        V425_CALLINGNETWORKTYPE         ,
        V434_ONLINECHARGINGFLAG         ,
        V457_PREPAID_BALANCE / 1000000 as   V457_PREPAID_BALANCE,
        V476_ONNETINDICATOR,
         V402_CALLTYPE             
        FROM  L1_VOICE V,DATE_DIM B,DATE_DIM C
        WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(V.V387_CHARGINGTIME,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(B.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(V.V387_CHARGINGTIME,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
        AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(V.PROCESSED_DATE, 'DD/MM/YYYY')
        AND TO_CHAR(V.PROCESSED_DATE,'RRRRMMDD') = VDATE;
        COMMIT;
        EXCEPTION
WHEN OTHERS THEN NULL;
END;
/

