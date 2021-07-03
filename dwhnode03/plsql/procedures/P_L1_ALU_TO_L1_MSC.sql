--
-- P_L1_ALU_TO_L1_MSC  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER03.P_L1_ALU_TO_L1_MSC IS
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
    AND LAYER = 'L1_MSC_ALU'
    AND SOURCE ='ALU';
    
    SELECT STATUS INTO VTMPSTATUS
    FROM TEMP_TABLE_ALTER_LOG
    WHERE TRUNC(ALTER_DATE)=TRUNC(SYSDATE)
    AND TABLE_NAME = 'L1_MSC_ALU';
    
    IF VSTATUS = 0 AND VTMPSTATUS =96 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L1_MSC_ALU',VDATE_KEY,'ALU','30',VCOUNT,'','',SYSDATE);
        COMMIT;
        
        INSERT INTO L1_MSC (PROCESSED_DATE, FILE_NAME, M01_CALLTYPE, M02_IMSI, M03_IMEI, M04_MSISDNAPARTY, M05_MSISDNBPARTY, M06_FORWARDEDMSISDN, M07_ANSWERTIMESTAMP, M08_CALLDUR, M09_LOCATION, M10_LAST_LOCATION, M11_CAUSEOFTERMINATION,M07_ANSWERTIMESTAMP_KEY, M07_ANSWERTIMESTAMP_HOUR)
        /* Formatted on 10/10/2020 1:31:29 PM (QP5 v5.256.13226.35538) */
          SELECT PROCESSED_DATE,
                 FILE_NAME,
                 MA01_CALLTYPE,
                 MA02_IMSI,
                 IMEI,
                 MA04_MSISDNAPARTY,
                 MA05_MSISDNBPARTY,
                 MA06_FORWARDEDMSISDN,
                 MA07_ANSWERTIMESTAMP,
                 MA08_CALLDUR,
                 LOCATION,
                 MA12_LAST_LOCATION,
                 MA11_CAUSEOFTERMINATION,
                 MA07_ANSWERTIMESTAMP_KEY,
                 MA07_ANSWERTIMESTAMP_HOUR         
            FROM (SELECT PROCESSED_DATE,
                         FILE_NAME,
                         MA01_CALLTYPE,
                         MA02_IMSI,
                         MA03_IMEI,
                         MA04_MSISDNAPARTY,
                         MA05_MSISDNBPARTY,
                         MA06_FORWARDEDMSISDN,
                         MA07_ANSWERTIMESTAMP,
                         MA08_CALLDUR,
                         M09_LOCATION,
                         MA12_LAST_LOCATION,
                         MA11_CAUSEOFTERMINATION,
                         MA07_ANSWERTIMESTAMP_KEY,
                         MA07_ANSWERTIMESTAMP_HOUR,
                         CASE
                            WHEN LENGTH (MA03_IMEI) > 13 THEN MA03_IMEI
                            WHEN LENGTH (MA03_IMEI) < 14 THEN NULL
                         END
                            IMEI,
                         CASE
                            WHEN LENGTH (M09_LOCATION) = 15 THEN M09_LOCATION
                            WHEN LENGTH (M09_LOCATION) != 15 THEN NULL
                         END
                            LOCATION
                    FROM (SELECT /*+ PARALLEL (A,16) */
                                TO_DATE (TO_CHAR (SYSDATE - 1, 'MM/DD/YYYY'),
                                         'MM/DD/YYYY')
                                    AS PROCESSED_DATE,
                                 FILE_NAME,
                                 DECODE (MA01_CALLTYPE,
                                         'MT SMS', 'SMSMT',
                                         'MO SMS', 'SMSMO',
                                         MA01_CALLTYPE)
                                    MA01_CALLTYPE,
                                 MA02_IMSI,
                                 MA03_IMEI,
                                 LPAD (MA04_MSISDNAPARTY, 13, 880) AS MA04_MSISDNAPARTY,
                                 MA05_MSISDNBPARTY,
                                 MA06_FORWARDEDMSISDN,
                                 '20' || MA07_ANSWERTIMESTAMP AS MA07_ANSWERTIMESTAMP,
                                 MA08_CALLDUR,
                                 LPAD (MA09_AREACODE || MA10_CELLID, 15, 47004)
                                    AS M09_LOCATION,
                                 LPAD (MA12_LAST_LOCATION, 15, 47004)
                                    AS MA12_LAST_LOCATION,
                                 MA11_CAUSEOFTERMINATION,
                                 B.DATE_KEY AS MA07_ANSWERTIMESTAMP_KEY,
                                 SUBSTR (MA07_ANSWERTIMESTAMP, 7, 4) AS MA07_ANSWERTIMESTAMP_HOUR
                            FROM L1_MSC_ALU A, DATE_DIM B
                           WHERE     SUBSTR ('20' || MA07_ANSWERTIMESTAMP, 1, 8) = TO_CHAR (B.DATE_VALUE, 'RRRRMMDD')
                                 AND MA04_MSISDNAPARTY IS NOT NULL
                                 AND MA05_MSISDNBPARTY IS NOT NULL
                                 AND MA07_ANSWERTIMESTAMP IS NOT NULL
                                 AND LENGTH(NVL(MA08_CALLDUR,0))<16))--add this condition length(MA08_CALLDUR)<16 (nt.GAZMSSA01.2020.11.18.1745.00010320201119004202.csv this cdr  one row CALLDUR value is 591527570382120617472
        GROUP BY PROCESSED_DATE,
                 FILE_NAME,
                 MA01_CALLTYPE,
                 MA02_IMSI,
                 IMEI,
                 MA04_MSISDNAPARTY,
                 MA05_MSISDNBPARTY,
                 MA06_FORWARDEDMSISDN,
                 MA07_ANSWERTIMESTAMP,
                 MA08_CALLDUR,
                 LOCATION,
                 MA12_LAST_LOCATION,
                 MA11_CAUSEOFTERMINATION,
                 MA07_ANSWERTIMESTAMP_KEY,
                 MA07_ANSWERTIMESTAMP_HOUR;
                 commit;
    UPDATE ETL_LOG SET STATUS = 96,
    UPDATE_TIME=SYSDATE
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L1_MSC_ALU';        
        COMMIT;
  ELSE
     INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
     VALUES              ('L1_MSC_ALU',VDATE_KEY,'ALU','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

