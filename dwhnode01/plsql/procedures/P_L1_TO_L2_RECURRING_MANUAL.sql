--
-- P_L1_TO_L2_RECURRING_MANUAL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_TO_L2_RECURRING_MANUAL (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
 BEGIN
        INSERT INTO L2_RECURRING
        SELECT /*+ PARALLEL(I,16) */
        C.DATE_KEY AS ETL_DATE_KEY,
        I.FILE_NAME,
        R4_SPLIT_CDR_REASON                  ,
        R9_STATUS                            ,
        R18_OBJ_TYPE                         ,
        R22_PRI_IDENTITY                     ,
        R24_SERVICE_CATEGORY                 ,
        R25_USAGE_SERVICE_TYPE               ,
        NVL(R41_DEBIT_AMOUNT,0) / 1000000 AS  R41_DEBIT_AMOUNT ,
        R373_MAINOFFERINGID           ,
        R374_PAYTYPE                         ,
        '880'||R375_CHARGINGPARTYNUMBER             ,
        F.DATE_KEY AS R377_CYCLEBEGINTIME_KEY   ,           
        TO_CHAR(TO_DATE( SUBSTR(R377_CYCLEBEGINTIME,9,4), 'HH24MI')+360/1440, 'HH24MI') AS  R377_CYCLEBEGINTIME_HOUR,--SUBSTR(R377_CYCLEBEGINTIME,9,4) AS  R377_CYCLEBEGINTIME_HOUR ,   
        R379_CYCLETYPE                       ,
        R384_PRODUCTID                       ,
        R385_OFFERINGID ,
        R386_OFFERINGINSTID                  ,
        R387_ORDERSTATUS                     ,
        R392_TRIGGERMODE                     ,
        R394_PRODUCTCODE                     ,
        R395_MAINBALANCEINFO                 ,
        R402_TAXINFO                         ,
        NVL(R408_PREPAID_BALANCE,0) / 1000000 AS R408_PREPAID_BALANCE ,
        R419_CALLINGNETWORKTYPE              ,
        R420_LOCALAREA                       ,
        R421_BUNDLEPACKAGE       
        FROM  L1_RECURRING I,DATE_DIM F,DATE_DIM C
        WHERE TO_CHAR(F.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(I.R377_CYCLEBEGINTIME,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(F.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(I.R377_CYCLEBEGINTIME,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
        AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(I.PROCESSED_DATE, 'DD/MM/YYYY')
        AND TO_CHAR(I.PROCESSED_DATE,'YYYYMMDD') = P_PROCESS_DATE;
        COMMIT;
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L2_RECURRING',VDATE_KEY,'mon','96',VCOUNT,'','',SYSDATE);
        COMMIT;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

