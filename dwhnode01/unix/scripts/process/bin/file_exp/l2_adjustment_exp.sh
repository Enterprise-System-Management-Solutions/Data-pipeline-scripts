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

dt=`date -d yesterday '+%Y%m%d'`

xdate=`sqlplus -s dwh_user/dwh_user_123 <<EOF
SET echo off
SET head off
SET feedback off
select date_key from date_dim where trunc(date_value)=trunc(sysdate-1);
EOF`


xdir=/data02/l2_csv_export_dump/l2_adjustment_$dt.csv

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
SELECT /*+ PARALLEL(A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||A5_PRI_IDENTITY||'~'||A6_PAY_TYPE||'~'||A8_CHANNEL_ID||'~'||A9_REASON_CODE||'~'||A11_ERROR_TYPE||'~'||A13_ADJUST_AMT||'~'||A17_ACCESS_METHOD||'~'||A21_STATUS||'~'||A22_ENTRY_DATE_HOUR||'~'||A28_REGION_ID||'~'||A30_DEBIT_AMOUNT||'~'||A31_RESERVED||'~'||A32_DEBIT_FROM_PREPAID||'~'||A33_DEBIT_FROM_ADVANCE_PREPAID||'~'||A34_DEBIT_FROM_POSTPAID||'~'||A37_TOTAL_TAX||'~'||A38_FREE_UNIT_AMOUNT_OF_TIMES||'~'||A39_PAY_FREE_UNIT_DURATION||'~'||A40_FREE_UNIT_AMOUNT_OF_FLUX||'~'||A44_CUR_BALANCE||'~'||A50_OPER_TYPE||'~'||A141_FU_OWN_TYPE||'~'||A150_FU_MEASURE_ID||'~'||A368_PRE_APPLY_TIME_KEY||'~'||A368_PRE_APPLY_HOUR||'~'||A461_BRANDID||'~'||A462_MAINOFFERINGID||'~'||A463_PAYTYPE||'~'||A469_USERSTATE||'~'||A470_OLDUSERSTATE||'~'||A491_TAX_AMOUNT||'~'||A498_TAX_PRICE_FLAG||'~'||A22_ENTRY_DATE_KEY
FROM L2_ADJUSTMENT A
WHERE ETL_DATE_KEY=$2
/
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $xdate
echo "$xdir"
