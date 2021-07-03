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

#dt=`date -d yesterday '+%Y%m%d'`

dt=$1

xdir=/data02/l2_csv_export_dump/l2_recharge_$dt.csv

C_hadoop_OUT()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
set echo off
set head off
set feedback off
set trimspool on
set headsep off
set termout off
set underline off
set linesize 32000;
set pages 0;
spool $1
SELECT /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||RE2_RECHARGE_CODE||'~'||RE3_RECHARGE_AMT||'~'||RE4_ACCT_ID||'~'||RE5_SUB_ID||'~'||RE6_PRI_IDENTITY||'~'||RE9_ORIGINAL_AMT||'~'||RE18_PAYMENT_TYPE||'~'||RE19_RECHARGE_TAX||'~'||RE21_RECHARGE_TYPE||'~'||RE22_CHANNEL_ID||'~'||RE24_RESULT_CODE||'~'||RE25_ERROR_TYPE||'~'||RE30_ENTRY_HOUR||'~'||RE42_REGION_ID||'~'||RE43_REGION_CODE||'~'||RE47_CARD_STATUS||'~'||RE50_CARD_AMOUNT||'~'||RE69_CUR_BALANCE||'~'||RE166_FU_OWN_TYPE||'~'||RE170_CUR_AMOUNT||'~'||RE486_RECHARGEAREACODE||'~'||RE487_RECHARGECELLID||'~'||RE489_MAINOFFERINGID||'~'||RE501_AGENTNAME||'~'||RE490_PAYTYPE||'~'||RE30_ENTRY_DATE_KEY
as my_query
FROM L2_RECHARGE A
WHERE ETL_DATE_KEY=(select date_key from date_dim where to_char(date_value,'rrrrmmdd')=$2);
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $dt
echo "$xdir"

