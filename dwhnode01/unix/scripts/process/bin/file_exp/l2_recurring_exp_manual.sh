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

xdir=/data02/l2_csv_export_dump/l2_recurring_$dt.csv

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
SELECT /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||R4_SPLIT_CDR_REASON||'~'||R9_STATUS||'~'||R18_OBJ_TYPE||'~'||R22_PRI_IDENTITY||'~'||R24_SERVICE_CATEGORY||'~'||R25_USAGE_SERVICE_TYPE||'~'||R41_DEBIT_AMOUNT||'~'||R373_MAINOFFERINGID||'~'||R374_PAYTYPE||'~'||R375_CHARGINGPARTYNUMBER||'~'||R377_CYCLEBEGINTIME_HOUR||'~'||R379_CYCLETYPE||'~'||R384_PRODUCTID||'~'||R385_OFFERINGID||'~'||R386_OFFERINGINSTID||'~'||R387_ORDERSTATUS||'~'||R392_TRIGGERMODE||'~'||R394_PRODUCTCODE||'~'||R395_MAINBALANCEINFO||'~'||R402_TAXINFO||'~'||R408_PREPAID_BALANCE||'~'||R419_CALLINGNETWORKTYPE||'~'||R420_LOCALAREA||'~'||R421_BUNDLEPACKAGE||'~'||R377_CYCLEBEGINTIME_KEY 
AS MY_QUERY
FROM L2_RECURRING A
WHERE ETL_DATE_KEY=(select date_key from date_dim where to_char(date_value,'rrrrmmdd')=$2);
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $dt
echo "$xdir"
