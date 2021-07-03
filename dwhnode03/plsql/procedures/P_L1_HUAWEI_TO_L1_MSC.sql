--
-- P_L1_HUAWEI_TO_L1_MSC  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER03.P_L1_HUAWEI_TO_L1_MSC IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VTMPSTATUS NUMBER;

BEGIN
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT DATE_KEY FROM DATE_DIM  WHERE TRUNC(DATE_VALUE) = TRUNC(SYSDATE-1));
    
    SELECT COUNT(STATUS) INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT DATE_KEY FROM DATE_DIM  WHERE TRUNC(DATE_VALUE) = TRUNC(SYSDATE-1))
    AND LAYER = 'L1_MSC_HUAWEI'
    AND SOURCE ='HUAWEI';
    
    SELECT STATUS INTO VTMPSTATUS
    FROM TEMP_TABLE_ALTER_LOG
    WHERE TRUNC(ALTER_DATE)=TRUNC(SYSDATE)
    AND TABLE_NAME = 'L1_MSC_HUAWEI';
    
    IF VSTATUS = 0 AND VTMPSTATUS =96 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L1_MSC_HUAWEI',VDATE_KEY,'HUAWEI','30',VCOUNT,'','',SYSDATE);
        COMMIT;
        
        INSERT INTO L1_MSC (PROCESSED_DATE, FILE_NAME, M01_CALLTYPE, M02_IMSI, M03_IMEI, M04_MSISDNAPARTY, M05_MSISDNBPARTY, M06_FORWARDEDMSISDN, M07_ANSWERTIMESTAMP, M08_CALLDUR, M09_LOCATION, M10_LAST_LOCATION, M11_CAUSEOFTERMINATION,M07_ANSWERTIMESTAMP_KEY, M07_ANSWERTIMESTAMP_HOUR)
        /* Formatted on 10/10/2020 1:39:43 PM (QP5 v5.256.13226.35538) */
          SELECT PROCESSED_DATE,
                 FILE_NAME,
                 MH01_CALLTYPE,
                 MH02_SERVEDIMSI,
                 IMEI,
                 MH04_APARTYMSISDN,
                 MH05_BPARTYMSISDN,
                 MH06_FORWARDINGMSISDN,
                 MH07_ORIGINATIONTIME,
                 CALLDURATION,
                 LOCATION,
                 MH11_LAST_LOCATION,
                 MH09_CAUSEFORTERM,
                 MH07_ORIGINATIONTIME_KEY,
                 MH07_ORIGINATIONTIME_HOUR
            FROM (SELECT PROCESSED_DATE,
                         FILE_NAME,
                         MH01_CALLTYPE,
                         MH02_SERVEDIMSI,
                         MH03_SERVEDIMEI,
                         MH04_APARTYMSISDN,
                         MH05_BPARTYMSISDN,
                         MH06_FORWARDINGMSISDN,
                         MH07_ORIGINATIONTIME,
                         MH08_CALLDURATION,
                         MH10_GLOBAAREAID,
                         MH11_LAST_LOCATION,
                         MH09_CAUSEFORTERM,
                         MH07_ORIGINATIONTIME_KEY,
                         MH07_ORIGINATIONTIME_HOUR,
                         CASE
                            WHEN LENGTH (MH03_SERVEDIMEI) > 13 THEN MH03_SERVEDIMEI
                            WHEN LENGTH (MH03_SERVEDIMEI) < 14 THEN NULL
                         END
                            IMEI,
                         CASE
                            WHEN LENGTH (MH08_CALLDURATION) < 5
                            THEN
                               MH08_CALLDURATION
                            WHEN    LENGTH (MH08_CALLDURATION) = 0
                                 OR LENGTH (MH08_CALLDURATION) IS NULL
                            THEN
                               MH08_CALLDURATION
                            WHEN LENGTH (MH08_CALLDURATION) > 4
                            THEN
                               NULL
                         END
                            CALLDURATION,
                         CASE
                            WHEN LENGTH (MH10_GLOBAAREAID) = 15 THEN MH10_GLOBAAREAID
                            WHEN LENGTH (MH10_GLOBAAREAID) != 15 THEN NULL
                         END
                            LOCATION
                    FROM (SELECT /*+ PARALLEL (A,16) */
                                TO_DATE (TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY'),
                                         'MM/DD/YYYY')
                                    AS PROCESSED_DATE,
                                 FILE_NAME,
                                 MH01_CALLTYPE,
                                 MH02_SERVEDIMSI,
                                 MH03_SERVEDIMEI,
                                 LPAD (MH04_APARTYMSISDN, 13, 880) AS MH04_APARTYMSISDN,
                                 MH05_BPARTYMSISDN,
                                 MH06_FORWARDINGMSISDN,
                                 '20' || MH07_ORIGINATIONTIME AS MH07_ORIGINATIONTIME,
                                 MH08_CALLDURATION,
                                 MH10_GLOBAAREAID,
                                 MH11_LAST_LOCATION,
                                 MH09_CAUSEFORTERM,
                                 DATE_KEY AS MH07_ORIGINATIONTIME_KEY,
                                 SUBSTR(MH07_ORIGINATIONTIME,7,4) AS MH07_ORIGINATIONTIME_HOUR
                            FROM L1_MSC_HUAWEI A, DATE_DIM B
                           WHERE     SUBSTR ('20' || MH07_ORIGINATIONTIME, 1, 8) =
                                        TO_CHAR (B.DATE_VALUE, 'RRRRMMDD')
                                 AND MH04_APARTYMSISDN IS NOT NULL
                                 AND MH05_BPARTYMSISDN IS NOT NULL
                                 AND MH07_ORIGINATIONTIME IS NOT NULL))
        GROUP BY PROCESSED_DATE,
                 FILE_NAME,
                 MH01_CALLTYPE,
                 MH02_SERVEDIMSI,
                 IMEI,
                 MH04_APARTYMSISDN,
                 MH05_BPARTYMSISDN,
                 MH06_FORWARDINGMSISDN,
                 MH07_ORIGINATIONTIME,
                 CALLDURATION,
                 LOCATION,
                 MH11_LAST_LOCATION,
                 MH09_CAUSEFORTERM,
                 MH07_ORIGINATIONTIME_KEY,
                 MH07_ORIGINATIONTIME_HOUR;
        COMMIT;

    UPDATE ETL_LOG SET STATUS = 96,
    UPDATE_TIME=SYSDATE
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L1_MSC_HUAWEI';        
        COMMIT;
  ELSE
     INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
     VALUES              ('L1_MSC_HUAWEI',VDATE_KEY,'HUAWEI','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

