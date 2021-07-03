PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode01
export ORACLE_UNQNAME=dwhdb01
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb01
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

DATA_INSERT_L2_DATA()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
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
FROM  L1_DATA partition($1) A,DATE_DIM B,DATE_DIM C
WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(A.G383_CHARGINGTIME,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(B.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(A.G383_CHARGINGTIME,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(A.PROCESSED_DATE, 'DD/MM/YYYY')
/
COMMIT
/
EXIT
EOF
}

DATA_INSERT_L2_DATA $1

echo "$1"
