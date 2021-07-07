export ORACLE_UNQNAME=DWH05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=/data01/app/oracle/product/12.2.0/db_1
export ORACLE_SID=DWH05

PATH=/usr/sbin:$PATH:$ORACLE_HOME/bin

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;


lock=/data02/scripts/process/bin/laila/csv/l3_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

#dt=`date -d yesterday  '+%d%m%Y'`

xdir=/data02/scripts/process/bin/laila/csv/l3_adjustment_count.csv

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
--REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

SELECT  /*+PARALLEL(V,10)*/ DD.DATE_VALUE,COUNT(*) FROM L3_ADJUSTMENT V,DATE_DIM DD
WHERE V.ETL_DATE_KEY=DD.DATE_KEY
AND TRUNC(DATE_VALUE) BETWEEN TRUNC(SYSDATE -10 ) AND TRUNC(SYSDATE-1)
GROUP BY DD.DATE_VALUE ORDER BY DD.DATE_VALUE;
/
EXIT
EOF

#echo "File Exported for $dt"

rm -f $lock

fi


