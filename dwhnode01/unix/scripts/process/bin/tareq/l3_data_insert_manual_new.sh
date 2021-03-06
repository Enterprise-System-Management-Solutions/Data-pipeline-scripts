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

DATA_INSERT_L3_DATA()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
INSERT INTO L3_DATA@DWH01TODWH05
SELECT /*+ PARALLEL(A,16) */
ETL_DATE_KEY                  ,
SUM(G41_DEBIT_AMOUNT)              ,
SUM(G51_FREE_UNIT_AMOUNT_OF_FLUX)  ,
G372_CALLINGPARTYNUMBER       ,
G375_CALLINGPARTYIMSI         ,
G379_CALLINGCELLID            ,
G383_CHARGINGTIME_KEY         ,
SUM(G384_TOTALFLUX)                ,
G389_SERVICEID                ,
G401_MAINOFFERINGID           ,
G403_PAYTYPE                  ,
G404_CHARGINGTYPE             ,
G412_SERVICETYPE              ,
G429_RATTYPE                  ,
G430_CHARGEPARTYINDICATOR     ,
G432_PRIMARYOFFERCHGAMT       ,
G435_TAXINFO                  ,
SUM(G446_PAY_FREE_UNIT_FLUX)       ,
SUM(G447_PAY_FREE_UNIT_DURATION)   ,
SUM(G448_PAY_DEBIT_AMOUNT )        ,
SUM(G449_PAY_DEBIT_FROM_PREPAID)   ,
SUM(G450_PAY_PREPAID_BALANCE )     ,
SUM(G453_PAY_POSTPAID_BALANCE)     ,
G455_SUBSCRIBERIDTYPE         ,
G467_ACCUMLATEDPOINT,
G383_CHARGINGTIME_HOUR,
G388_IMEI,
G418_LASTEFFECTOFFERING   
FROM L2_DATA A
WHERE ETL_DATE_KEY= $1
GROUP BY 
ETL_DATE_KEY                  ,
G372_CALLINGPARTYNUMBER       ,
G375_CALLINGPARTYIMSI         ,
G379_CALLINGCELLID            ,
G383_CHARGINGTIME_KEY         ,
G389_SERVICEID                ,
G401_MAINOFFERINGID           ,
G403_PAYTYPE                  ,
G404_CHARGINGTYPE             ,
G412_SERVICETYPE              ,
G429_RATTYPE                  ,
G430_CHARGEPARTYINDICATOR     ,
G432_PRIMARYOFFERCHGAMT       ,
G435_TAXINFO                  ,
G455_SUBSCRIBERIDTYPE         ,
G467_ACCUMLATEDPOINT,
G383_CHARGINGTIME_HOUR,
G388_IMEI,
G418_LASTEFFECTOFFERING                       
/
COMMIT
/
EXIT
EOF
}

DATA_INSERT_L3_DATA $1

echo "$1"

