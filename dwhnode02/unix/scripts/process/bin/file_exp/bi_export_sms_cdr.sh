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
spool ${1}for_sms_cdr_wo_head_${2}.csv
SELECT S22_PRI_IDENTITY||'|'||S4_SPLIT_CDR_REASON||'|'||S9_STATUS||'|'||S18_OBJ_TYPE||'|'||S24_SERVICE_CATEGORY||'|'||S41_DEBIT_AMOUNT||'|'||S372_CALLINGPARTYNUMBER||'|'||S373_CALLEDPARTYNUMBER||'|'||S374_CALLINGPARTYIMSI||'|'||S378_SERVICEFLOW||'|'||S379_CALLFORWARDINDICATOR||'|'||S381_CALLINGCELLID||'|'||S387_CHARGINGTIME_KEY||'|'||CHARGING_DATE||'|'||S387_CHARGINGTIME_HOUR||'|'||S388_SENDRESULT||'|'||S391_SMLENGTH||'|'||S393_REFUNDINDICATOR||'|'||S395_MAINOFFERINGID||'|'||S397_CHARGEPARTYINDICATOR||'|'||S398_PAYTYPE||'|'||S400_SMSTYPE||'|'||S401_ONNETINDICATOR||'|'||S416_SPECIALNUMBERINDICATOR||'|'||S417_NPFLAG||'|'||S418_NPPREFIX||'|'||S438_SPECIALZONEID||'|'||S445_PRIMARYOFFERCHGAMT||'|'||S448_TAXINFO||'|'||S456_DISCOUNTOFLASTEFFOFFERING||'|'||S457_UNROUND||'|'||S459_PREPAID_BALANCE||'|'||S460_POSTPAID_BALANCE||'|'||S479_RATED_OFFER_ID||'|'||S25_USAGE_SERVICE_TYPE||'|'||S402_ROAMSTATE||'|'||S434_LASTEFFECTOFFERING as
FROM SHAHIN_CDR_FROM_BI_SMS_FINAL_MARCH
WHERE S372_CALLINGPARTYNUMBER =$2
OR S373_CALLEDPARTYNUMBER =$2;
EXIT
EOF
}

export_process $xdir $i

cd /data02/cdr_export/

cat shahin_cdr_from_bi_sms_final.csv > for_sms_cdr_${i}.csv
cat for_sms_cdr_wo_head_${i}.csv >> for_sms_cdr_${i}.csv
sed -i '/^$/d' for_sms_cdr_${i}.csv
rm -f for_sms_cdr_wo_head_${i}.csv

done

