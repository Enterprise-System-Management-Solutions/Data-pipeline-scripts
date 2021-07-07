--
-- P_L2_TO_L3_SMS_MANUAL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L2_TO_L3_SMS_MANUAL (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VL2STATUS NUMBER;
    VL3STATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    SELECT DATE_KEY INTO VDATE_KEY 
    FROM DATE_DIM@DWH05TODWH01
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);
            
    INSERT INTO L3_SMS
    SELECT /*+ PARALLEL(L2_SMS,16) */
    ETL_DATE_KEY                   ,
    S4_SPLIT_CDR_REASON             ,
    S9_STATUS                       ,
    S18_OBJ_TYPE                    ,
    S22_PRI_IDENTITY                ,
    S24_SERVICE_CATEGORY            ,
    SUM(S41_DEBIT_AMOUNT )               ,
    S372_CALLINGPARTYNUMBER         ,
    S373_CALLEDPARTYNUMBER          ,
    S374_CALLINGPARTYIMSI           ,
    S378_SERVICEFLOW                ,
    S379_CALLFORWARDINDICATOR       ,
    S381_CALLINGCELLID              ,
    S387_CHARGINGTIME_KEY           ,
    S387_CHARGINGTIME_HOUR          ,
    S388_SENDRESULT                 ,
    S391_SMLENGTH                   ,
    S393_REFUNDINDICATOR            ,
    S395_MAINOFFERINGID             ,
    S397_CHARGEPARTYINDICATOR       ,
    S398_PAYTYPE                    ,
    S400_SMSTYPE                    ,
    S401_ONNETINDICATOR             ,
    S416_SPECIALNUMBERINDICATOR     ,
    S417_NPFLAG                     ,
    S418_NPPREFIX                   ,
    S438_SPECIALZONEID              ,
    S445_PRIMARYOFFERCHGAMT         ,
    S448_TAXINFO                    ,
    S456_DISCOUNTOFLASTEFFOFFERING  ,
    S457_UNROUND                    ,
    SUM(S459_PREPAID_BALANCE)            ,
    SUM(S460_POSTPAID_BALANCE)           ,
    S479_RATED_OFFER_ID  ,
    S25_USAGE_SERVICE_TYPE, 
    S402_ROAMSTATE,
    S434_LASTEFFECTOFFERING         
    FROM L2_SMS@DWH05TODWH01
    WHERE ETL_DATE_KEY= VDATE_KEY
    GROUP BY 
    ETL_DATE_KEY ,
    S4_SPLIT_CDR_REASON             ,
    S9_STATUS                       ,
    S18_OBJ_TYPE                    ,
    S22_PRI_IDENTITY                ,
    S24_SERVICE_CATEGORY            ,
    S372_CALLINGPARTYNUMBER         ,
    S373_CALLEDPARTYNUMBER          ,
    S374_CALLINGPARTYIMSI           ,
    S378_SERVICEFLOW                ,
    S379_CALLFORWARDINDICATOR       ,
    S381_CALLINGCELLID              ,
    S387_CHARGINGTIME_KEY           ,
    S387_CHARGINGTIME_HOUR          ,
    S388_SENDRESULT                 ,
    S391_SMLENGTH                   ,
    S393_REFUNDINDICATOR            ,
    S395_MAINOFFERINGID             ,
    S397_CHARGEPARTYINDICATOR       ,
    S398_PAYTYPE                    ,
    S400_SMSTYPE                    ,
    S401_ONNETINDICATOR             ,
    S416_SPECIALNUMBERINDICATOR     ,
    S417_NPFLAG                     ,
    S418_NPPREFIX                   ,
    S438_SPECIALZONEID              ,
    S445_PRIMARYOFFERCHGAMT         ,
    S448_TAXINFO                    ,
    S456_DISCOUNTOFLASTEFFOFFERING  ,
    S457_UNROUND                    ,
    S479_RATED_OFFER_ID,
    S25_USAGE_SERVICE_TYPE,
    S402_ROAMSTATE,
    S434_LASTEFFECTOFFERING;
    COMMIT;
    INSERT INTO ETL_LOG@DWH05TODWH01 (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
    VALUES              ('L3_SMS',VDATE_KEY,'sms','96','','','',SYSDATE);
    COMMIT;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/
