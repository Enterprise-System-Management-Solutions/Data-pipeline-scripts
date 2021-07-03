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



lock=/data02/scripts/process/bin/laila/L2  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

#dt=`date -d yesterday  '+%d%m%Y'`

xdir=/data02/scripts/process/bin/laila/csv/L2_cm_count.csv

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET ECHO OFF
SET WRAP OFF
SET HEAD ON
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET HEADSEP ON
SET TERMOUT OFF
SET UNDERLINE OFF
SET LINESIZE 32000;
SET PAGESIZE 40000;
SET LONG 50000;
SPOOL $xdir
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

SELECT  /*+PARALLEL(V,10)*/ DD.DATE_VALUE,COUNT(*) FROM L2_MANAGEMENT V,DATE_DIM DD
WHERE V.ETL_DATE_KEY=DD.DATE_KEY
AND TRUNC(DATE_VALUE) BETWEEN TRUNC(SYSDATE -10 ) AND TRUNC(SYSDATE-1)
GROUP BY DD.DATE_VALUE ORDER BY DD.DATE_VALUE;
EXIT
EOF

#echo "File Exported for $dt"

rm -f $lock

fi


