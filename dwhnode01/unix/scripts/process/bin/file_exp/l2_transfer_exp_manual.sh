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

xdir=/data02/l2_csv_export_dump/l2_transfer_$dt.csv

C_hadoop_OUT()
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
set pages 0;
spool $1
SELECT /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||T4_CUST_ID||'~'||T6_PRI_IDENTITY||'~'||T9_REASON_CODE||'~'||T10_RESULT_CODE||'~'||T11_ERROR_TYPE||'~'||T15_TRANSFER_TYPE||'~'||T16_TRANSFER_AMT||'~'||T17_TRANSFER_DATE_KEY||'~'||T17_TRANSFER_DATE_HOUR||'~'||T18_TRANSFER_TRANS_ID||'~'||T22_DIAMETER_SESSIONID||'~'||T24_REVERSAL_TRANS_ID||'~'||T25_REVERSAL_REASON_CODE||'~'||T28_STATUS||'~'||T29_ENTRY_DATE_HOUR||'~'||T39_BALANCE_TYPE||'~'||T40_CUR_BALANCE||'~'||T41_CHG_BALANCE||'~'||T46_OPER_TYPE||'~'||T458_MAINOFFERINGID||'~'||T459_PAYTYPE||'~'||T477_OTHERNUMBER||'~'||T480_PREPAID_BALANCE||'~'||T481_POSTPAID_BALANCE||'~'||T489_CHARGE_OF_FUND||'~'||T29_ENTRY_DATE_KEY
 AS MY_QUERY
FROM L2_TRANSFER A
WHERE ETL_DATE_KEY=(select date_key from date_dim where to_char(date_value,'rrrrmmdd')=$2);
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $dt
echo "$xdir"

