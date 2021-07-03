--
-- P_L1_ALU_TO_L1_MSC_OLD  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER03.P_L1_ALU_TO_L1_MSC_old IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
BEGIN
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT DATE_KEY FROM DATE_DIM  WHERE TRUNC(DATE_VALUE) = TRUNC(SYSDATE-1));
    
    SELECT COUNT(STATUS) INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT DATE_KEY FROM DATE_DIM  WHERE TRUNC(DATE_VALUE) = TRUNC(SYSDATE-1))
    AND LAYER = 'L1_MSC_ALU'
    AND SOURCE ='ALU';
    
    IF VSTATUS = 0 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L1_MSC_ALU',VDATE_KEY,'ALU','30',VCOUNT,'','',SYSDATE);
        COMMIT;
        
        INSERT INTO L1_MSC (PROCESSED_DATE, FILE_NAME, M01_CALLTYPE, M02_IMSI, M03_IMEI, M04_MSISDNAPARTY, M05_MSISDNBPARTY, M06_FORWARDEDMSISDN, M07_ANSWERTIMESTAMP, M08_CALLDUR, M09_LOCATION, M10_LAST_LOCATION, M11_CAUSEOFTERMINATION)
        SELECT  PROCESSED_DATE,FILE_NAME, MA01_CALLTYPE, MA02_IMSI, IMEI, MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN,MA07_ANSWERTIMESTAMP, MA08_CALLDUR, LOCATION, MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION
        FROM
        (SELECT PROCESSED_DATE,FILE_NAME, MA01_CALLTYPE, MA02_IMSI, MA03_IMEI, MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN,MA07_ANSWERTIMESTAMP, MA08_CALLDUR, M09_LOCATION, MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION,
        CASE
        WHEN LENGTH(MA03_IMEI)>13
        THEN MA03_IMEI
        WHEN LENGTH(MA03_IMEI)<14
        THEN NULL

        END IMEI,

        CASE
        WHEN LENGTH(M09_LOCATION)=15
        THEN M09_LOCATION
        WHEN LENGTH(M09_LOCATION)!=15
        THEN NULL

        END LOCATION

        FROM
        (SELECT /*+ PARALLEL (A,16) */ TO_DATE(TO_CHAR(SYSDATE-1, 'MM/DD/YYYY'), 'MM/DD/YYYY')AS PROCESSED_DATE,FILE_NAME, decode(MA01_CALLTYPE,'MT SMS','SMSMT','MO SMS','SMSMO',MA01_CALLTYPE)MA01_CALLTYPE, MA02_IMSI, MA03_IMEI, LPAD(MA04_MSISDNAPARTY,13,880) AS MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN, '20'||MA07_ANSWERTIMESTAMP AS MA07_ANSWERTIMESTAMP, MA08_CALLDUR, LPAD(MA09_AREACODE||MA10_CELLID,15,47004) AS M09_LOCATION, LPAD(MA12_LAST_LOCATION,15,47004) AS MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION
        FROM L1_MSC_ALU A
        WHERE MA04_MSISDNAPARTY is not null
        and MA05_MSISDNBPARTY is not null
        and MA07_ANSWERTIMESTAMP is not null)
        )
        GROUP BY PROCESSED_DATE,FILE_NAME, MA01_CALLTYPE, MA02_IMSI, IMEI, MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN,MA07_ANSWERTIMESTAMP, MA08_CALLDUR, LOCATION, MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION;
        COMMIT;
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

