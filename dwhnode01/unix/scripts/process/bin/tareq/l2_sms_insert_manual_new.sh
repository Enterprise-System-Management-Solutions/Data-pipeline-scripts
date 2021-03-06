
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


DATA_INSERT_L2_SMS()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
INSERT INTO L2_SMS
SELECT /*+ PARALLEL(A,16) */
C.DATE_KEY AS ETL_DATE_KEY                    ,
A.FILE_NAME                      ,
S4_SPLIT_CDR_REASON            ,
S9_STATUS                      ,
S18_OBJ_TYPE                   ,
S22_PRI_IDENTITY               ,
S24_SERVICE_CATEGORY           ,
NVL(S41_DEBIT_AMOUNT,0) / 1000000 AS S41_DEBIT_AMOUNT,
S372_CALLINGPARTYNUMBER        ,
S373_CALLEDPARTYNUMBER         ,
S374_CALLINGPARTYIMSI          ,
S378_SERVICEFLOW               ,
S379_CALLFORWARDINDICATOR      ,
S381_CALLINGCELLID             ,
B.DATE_KEY AS S387_CHARGINGTIME_KEY          ,
TO_CHAR(TO_DATE( SUBSTR(S387_CHARGINGTIME,9,4), 'HH24MI')+360/1440, 'HH24MI') AS  S387_CHARGINGTIME_HOUR,--SUBSTR(S387_CHARGINGTIME,9,4) AS S387_CHARGINGTIME_HOUR         ,
S388_SENDRESULT                ,
S391_SMLENGTH                  ,
S393_REFUNDINDICATOR           ,
S395_MAINOFFERINGID            ,
S397_CHARGEPARTYINDICATOR      ,
S398_PAYTYPE                   ,
S400_SMSTYPE                   ,
S401_ONNETINDICATOR            ,
S416_SPECIALNUMBERINDICATOR    ,
S417_NPFLAG                    ,
S418_NPPREFIX                  ,
S434_LASTEFFECTOFFERING        ,
S438_SPECIALZONEID             ,
S445_PRIMARYOFFERCHGAMT        ,
S448_TAXINFO                   ,
S456_DISCOUNTOFLASTEFFOFFERING ,
S457_UNROUND                   ,
NVL(S459_PREPAID_BALANCE,0) / 1000000 AS S459_PREPAID_BALANCE,
NVL(S460_POSTPAID_BALANCE,0) / 1000000 AS S460_POSTPAID_BALANCE,
S479_RATED_OFFER_ID    ,
S25_USAGE_SERVICE_TYPE  ,
S402_ROAMSTATE 
FROM L1_SMS partition($1) A,DATE_DIM B,DATE_DIM C
WHERE TO_CHAR(B.DATE_VALUE,'YYYYMMDD')=TO_CHAR(TO_DATE( SUBSTR(A.S387_CHARGINGTIME,1,12), 'YYYYMMDDHH24MI')+6/24, 'YYYYMMDD')--WHERE TO_DATE(B.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(TO_DATE( SUBSTR(A.S387_CHARGINGTIME,1,8), 'YYYYMMDD'), 'DD/MM/YYYY')
AND TO_DATE(C.DATE_VALUE,'DD/MM/YYYY')=TO_DATE(A.PROCESSED_DATE, 'DD/MM/YYYY')
/
commit
/
EXIT
EOF
}

DATA_INSERT_L2_SMS $1
echo "$1"


