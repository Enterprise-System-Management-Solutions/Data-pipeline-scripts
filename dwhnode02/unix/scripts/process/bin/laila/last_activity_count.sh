export tORACLE_UNQNAME=DWH05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=/data01/app/oracle/product/12.2.0/db_1
export ORACLE_SID=DWH05

PATH=/usr/sbin:$PATH:$ORACLE_HOME/bin

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;


lock=/data02/scripts/process/bin/laila/last_activity  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

#dt=`date -d yesterday  '+%d%m%Y'`

xdir=/data02/scripts/process/bin/laila/csv/last_activity_count.csv
echo"last_activity"
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

SELECT COUNT(*) as last_active_msisdn
FROM
LAST_ACTIVITY_FCT A,DATE_DIM B
WHERE A.ETL_DATE_KEY =(SELECT ETL_DATE_KEY FROM DATE_DIM WHERE DATE_VALUE = TO_DATE(SYSDATE-1,'DD/MM/RRRR'))
AND A.ETL_DATE_KEY=B.DATE_KEY

/
EXIT
EOF

echo "File Exported for $dt"

rm -f $lock

fi


