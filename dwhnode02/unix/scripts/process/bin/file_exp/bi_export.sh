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
spool ${1}for_recharge_cdr_wo_head_${2}.csv
SELECT RE6_PRI_IDENTITY||'|'||RE2_RECHARGE_CODE||'|'||RE3_RECHARGE_AMT||'|'||RE4_ACCT_ID||'|'||RE5_SUB_ID||'|'||RE9_ORIGINAL_AMT||'|'||RE18_PAYMENT_TYPE||'|'||RE19_RECHARGE_TAX||'|'||RE21_RECHARGE_TYPE||'|'||RE22_CHANNEL_ID||'|'||RE24_RESULT_CODE||'|'||RE25_ERROR_TYPE||'|'||RE30_ENTRY_DATE_KEY||'|'||ENTRY_DATE||'|'||RE42_REGION_ID||'|'||RE43_REGION_CODE||'|'||RE47_CARD_STATUS||'|'||RE50_CARD_AMOUNT||'|'||RE69_CUR_BALANCE||'|'||RE170_CUR_AMOUNT||'|'||RE486_RECHARGEAREACODE||'|'||RE487_RECHARGECELLID||'|'||RE489_MAINOFFERINGID||'|'||RE501_AGENTNAME||'|'||RE490_PAYTYPE||'|'||RE30_ENTRY_HOUR AS QUERYS 
FROM SHAHIN_CDR_FROM_BI_RECHARGE_FINAL_MARCH
WHERE RE6_PRI_IDENTITY=$2;
EXIT
EOF
}

export_process $xdir $i

cd /data02/cdr_export/

cat shahin_cdr_from_bi_recharge_final.csv > for_recharge_cdr_${i}.csv
cat for_recharge_cdr_wo_head_${i}.csv >> for_recharge_cdr_${i}.csv
sed -i '/^$/d' for_recharge_cdr_${i}.csv
rm -f for_recharge_cdr_wo_head_${i}.csv

done

