--
-- P_L2_TO_L3_CONTENT  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L2_TO_L3_CONTENT (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VL2STATUS NUMBER;
    VL3STATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT COUNT(STATUS) INTO VL3STATUS
    FROM ETL_LOG@DWH05TODWH01
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE)
    AND LAYER = 'L3_CONTENT'
    AND SOURCE = 'com'
    AND STATUS = 96 ; 
    
    SELECT DATE_KEY INTO VDATE_KEY 
    FROM DATE_DIM@DWH05TODWH01
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);--(SELECT A.DATE_KEY FROM DATE_DIM A WHERE TO_DATE(A.DATE_VALUE,'DD/MM/YYYY') = TO_DATE(SYSDATE,'DD/MM/YYYY'));
        
    SELECT STATUS INTO VL2STATUS
    FROM ETL_LOG@DWH05TODWH01
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE)
    AND LAYER = 'L2_CONTENT'
    AND SOURCE = 'com';  
    
      
   IF VL3STATUS = 0 THEN   
   
       IF VL2STATUS = 96 THEN
        INSERT INTO ETL_LOG@DWH05TODWH01 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L3_CONTENT',VDATE_KEY,'com','30','','','',SYSDATE);
        
        INSERT INTO L3_CONTENT
        SELECT /*+ PARALLEL(L2_CONTENT,8)*/
        ETL_DATE_KEY                   ,
        CO4_SPLIT_CDR_REASON           ,
        CO9_STATUS                     ,
        CO18_OBJ_TYPE                  ,
        CO22_PRI_IDENTITY              ,
        CO24_SERVICE_CATEGORY          ,
        CO25_USAGE_SERVICE_TYPE        ,
        SUM(CO41_DEBIT_AMOUNT)         ,
        CO372_CALLINGPARTYNUMBER       ,
        CO373_CALLINGPARTYIMSI         ,
        CO374_CHARGINGTYPE             ,
        CO375_CHARGINGUSAGETYPE        ,
        CO382_SERVICETYPE              ,
        CO383_CONTENTTYPE              ,
        CO384_SERVICECAPABILITY        ,
        CO385_PROVISIONTYPE            ,
        CO386_CATEGORYTYPE             ,
        SUM(CO388_TIMES)               ,
        SUM(CO389_DURATION)            ,
        CO396_MAINOFFERINGID           ,
        CO402_STARTTIMEOFBILLCYL_KEY   ,
        CO402_STARTTIMEOFBILLCYL_HOUR  ,
        CO405_MAINBALANCEINFO          ,
        CO406_CHGBALANCEINFO           ,
        CO407_CHGFREEUNITINFO          ,
        CO410_PAYTYPE                  ,
        SUM(CO431_PREPAID_BALANCE)     ,
        SUM(CO432_POSTPAID_BALANCE)    ,
        COUNT(ETL_DATE_KEY)
        FROM L2_CONTENT@DWH05TODWH01
        WHERE ETL_DATE_KEY= VDATE_KEY
        GROUP BY 
        ETL_DATE_KEY                   , 
        CO4_SPLIT_CDR_REASON           ,
        CO9_STATUS                     ,
        CO18_OBJ_TYPE                  ,
        CO22_PRI_IDENTITY              ,
        CO24_SERVICE_CATEGORY          ,
        CO25_USAGE_SERVICE_TYPE        ,
        CO372_CALLINGPARTYNUMBER       ,
        CO373_CALLINGPARTYIMSI         ,
        CO374_CHARGINGTYPE             ,
        CO375_CHARGINGUSAGETYPE        ,
        CO382_SERVICETYPE              ,
        CO383_CONTENTTYPE              ,
        CO384_SERVICECAPABILITY        ,
        CO385_PROVISIONTYPE            ,
        CO386_CATEGORYTYPE             ,
        CO396_MAINOFFERINGID           ,
        CO402_STARTTIMEOFBILLCYL_KEY   ,
        CO402_STARTTIMEOFBILLCYL_HOUR  ,
        CO405_MAINBALANCEINFO          ,
        CO406_CHGBALANCEINFO           ,
        CO407_CHGFREEUNITINFO          ,
        CO410_PAYTYPE                  ;                
        COMMIT;
        UPDATE ETL_LOG@DWH05TODWH01 SET STATUS = 96,
        UPDATE_TIME=SYSDATE 
        WHERE DATE_KEY = VDATE_KEY
        AND LAYER = 'L3_CONTENT';        
        COMMIT;
    END IF;
   ELSE
     INSERT INTO ETL_LOG@DWH05TODWH01 (LAYER, DATE_KEY, SOURCE, STATUS, INSERT_TIME)
     VALUES              ('L3_CONTENT',VDATE_KEY,'com','34',SYSDATE);
    COMMIT;
    END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

