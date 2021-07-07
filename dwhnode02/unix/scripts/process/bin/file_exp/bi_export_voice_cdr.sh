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
spool ${1}for_voice_cdr_wo_head_${2}.csv
SELECT V372_CALLINGPARTYNUMBER||'|'||V373_CALLEDPARTYNUMBER||'|'||V24_SERVICE_CATEGORY||'|'||V25_USAGE_SERVICE_TYPE||'|'||V35_RATE_USAGE||'|'||V36_SERVICE_UNIT_TYPE||'|'||V41_DEBIT_AMOUNT||'|'||V44_DEBIT_FROM_ADVANCE_PRE||'|'||V49_PAY_FREE_UNIT_TIMES||'|'||V50_PAY_FREE_UNIT_DURATION||'|'||V55_CUR_BALANCE||'|'||V378_SERVICEFLOW||'|'||V380_CALLINGROAMINFO||'|'||V381_CALLINGCELLID||'|'||V383_CALLEDCELLID||'|'||V386_BEARERCAPABILITY||'|'||V387_CHARGINGTIME_KEY||'|'||CHARGING_DATE||'|'||V387_CHARGINGTIME_HOUR||'|'||V389_TERMINATIONREASON||'|'||V391_IMEI||'|'||V394_REDIRECTINGPARTYID||'|'||V395_MSCADDRESS||'|'||V397_MAINOFFERINGID||'|'||V400_PAYTYPE||'|'||V403_ROAMSTATE||'|'||V405_CALLINGHOMEAREANUMBER||'|'||V417_HOTLINEINDICATOR||'|'||V425_CALLINGNETWORKTYPE||'|'||V434_ONLINECHARGINGFLAG||'|'||V457_PREPAID_BALANCE||'|'||V476_ONNETINDICATOR||'|'||V402_CALLTYPE||'|'||V436_LASTEFFECTOFFERING AS 
FROM SHAHIN_CDR_FROM_BI_VOICE_FINAL_MARCH
WHERE V372_CALLINGPARTYNUMBER='$2'
OR V373_CALLEDPARTYNUMBER='$2';
EXIT
EOF
}

export_process $xdir $i

cd /data02/cdr_export/

cat shahin_cdr_from_bi_voice_final.csv > for_voice_cdr_${i}.csv
cat for_voice_cdr_wo_head_${i}.csv >> for_voice_cdr_${i}.csv
sed -i '/^$/d' for_voice_cdr_${i}.csv
rm -f for_voice_cdr_wo_head_${i}.csv

done

