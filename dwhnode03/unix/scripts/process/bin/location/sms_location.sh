#Author :       Tareq
#Date   :       20-08-2020
#!/bin/bash


PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode03
export ORACLE_UNQNAME=dwhdb03
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb03
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

TRUNCATE TABLE L3_SMS DROP STORAGE;
INSERT INTO L3_SMS
SELECT /*+ PARALLEL (A,16) */
LPAD(S22_PRI_IDENTITY,13,880) S22_PRI_IDENTITY, S395_MAINOFFERINGID, S41_DEBIT_AMOUNT/1000000 AS S41_DEBIT_AMOUNT, TO_CHAR(TO_DATE( SUBSTR(S387_CHARGINGTIME,1,14), 'YYYYMMDDHH24MISS')+6/24, 'YYYYMMDDHH24MISS') S387_CHARGINGTIME
FROM L1_SMS_TEMP_FULL@DWH03TODWH01 A
WHERE S378_SERVICEFLOW=1;
COMMIT;

INSERT INTO SMS_LOCATION_FCT
SELECT DATE_KEY,S22_PRI_IDENTITY, CALLINGCELLID, S395_MAINOFFERINGID, S41_DEBIT_AMOUNT,S387_CHARGINGTIME
FROM
(
    SELECT /*+ PARALLEL (A,16)*/ DATE_KEY,S22_PRI_IDENTITY, M09_LOCATION AS CALLINGCELLID, S395_MAINOFFERINGID, S41_DEBIT_AMOUNT,S387_CHARGINGTIME
    FROM
        (SELECT /*+ PARALLEL (A,16)*/ (SELECT DATE_KEY FROM DATE_DIM WHERE TO_CHAR(DATE_VALUE,'RRRRMMDD')=TO_CHAR(SYSDATE-1,'RRRRMMDD'))DATE_KEY,S22_PRI_IDENTITY, M09_LOCATION, S395_MAINOFFERINGID, S41_DEBIT_AMOUNT, SUBSTR(S387_CHARGINGTIME,1,13)S387_CHARGINGTIME
        FROM L3_SMS B
        LEFT OUTER JOIN  L1_MSC A
        ON S22_PRI_IDENTITY=M04_MSISDNAPARTY
        AND PROCESSED_DATE BETWEEN TO_DATE(SYSDATE-4,'DD/MM/RRRR') AND TO_DATE(SYSDATE-1,'DD/MM/RRRR')
        AND SUBSTR(S387_CHARGINGTIME,1,12)=SUBSTR(M07_ANSWERTIMESTAMP,1,12)
        )
    GROUP BY DATE_KEY,S22_PRI_IDENTITY, M09_LOCATION, S395_MAINOFFERINGID, S41_DEBIT_AMOUNT,S387_CHARGINGTIME
 )
;
COMMIT;
EXIT
EOF
