#!/bin/bash
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode02
export ORACLE_UNQNAME=dwhdb02
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb02
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


xdir=/data02/cdr_export/

for i in `cat /data02/cdr_export/bi_msisdn.csv`
do

export_process()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
set trimspool on
set headsep off
set termout off
set underline off
SET LINESIZE 32000;
SET PAGESIZE 40000;
SET LONG 50000;
spool ${1}for_data_cdr_wo_head_${2}.csv
SELECT G372_CALLINGPARTYNUMBER||'|'||G41_DEBIT_AMOUNT||'|'||G51_FREE_UNIT_AMOUNT_OF_FLUX||'|'||G375_CALLINGPARTYIMSI||'|'||G379_CALLINGCELLID||'|'||G383_CHARGINGTIME_KEY||'|'||CHARGING_DATE||'|'||G384_TOTALFLUX||'|'||G389_SERVICEID||'|'||G401_MAINOFFERINGID||'|'||G403_PAYTYPE||'|'||G404_CHARGINGTYPE||'|'||G412_SERVICETYPE||'|'||G429_RATTYPE||'|'||G430_CHARGEPARTYINDICATOR||'|'||G432_PRIMARYOFFERCHGAMT||'|'||G435_TAXINFO||'|'||G446_PAY_FREE_UNIT_FLUX||'|'||G447_PAY_FREE_UNIT_DURATION||'|'||G448_PAY_DEBIT_AMOUNT||'|'||G449_PAY_DEBIT_FROM_PREPAID||'|'||G450_PAY_PREPAID_BALANCE||'|'||G453_PAY_POSTPAID_BALANCE||'|'||G455_SUBSCRIBERIDTYPE||'|'||G467_ACCUMLATEDPOINT||'|'||G383_CHARGINGTIME_HOUR||'|'||G388_IMEI||'|'||G418_LASTEFFECTOFFERING as querys
FROM SHAHIN_CDR_FROM_BI_DATA_FINAL_MARCH
WHERE G372_CALLINGPARTYNUMBER=$2;
EXIT
EOF
}

export_process $xdir $i


cd /data02/cdr_export/

cat shahin_cdr_from_bi_data_final.csv > for_data_cdr_${i}.csv
cat for_data_cdr_wo_head_${i}.csv >> for_data_cdr_${i}.csv
sed -i '/^$/d' for_data_cdr_${i}.csv
rm -f for_data_cdr_wo_head_${i}.csv

done
