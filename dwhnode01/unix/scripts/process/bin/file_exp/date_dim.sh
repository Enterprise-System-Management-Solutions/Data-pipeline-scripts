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

xdate=`sqlplus -s dwh_user/dwh_user_123 <<EOF
SET echo off
SET head off
SET feedback off
select date_key from date_dim where trunc(date_value)=trunc(sysdate-1);
EOF`


dt=`date -d yesterday '+%Y%m%d'`
xdir=/data02/l2_csv_export_dump/date_dim_$dt.csv

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
SET PAGESIZE 40000;
SET LONG 50000;
set pages 0;
spool $1
SELECT DATE_KEY||'~'||TO_CHAR(DATE_VALUE,'YYYY-MM-DD')||'~'||DAYS||'~'||MONTH_SHORT||'~'||MONTH_NUM||'~'||TRIM(MONTH_LONG)||'~'||MONTH_KEY||'~'||YEAR AS CUSTOM_QUERY
FROM DATE_DIM
/
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $xdate
echo "$xdir"

