export ORACLE_UNQNAME=DWH05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=/data01/app/oracle/product/12.2.0/db_1
export ORACLE_SID=DWH05

PATH=/usr/sbin:$PATH:$ORACLE_HOME/bin

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;


lock=/data02/scripts/process/bin/laila/subscription  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

#dt=`date -d yesterday  '+%d%m%Y'`

xdir=/data02/scripts/process/bin/laila/csv/subscription_count.csv
echo " hi" > $xdir

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET ECHO ON
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

select count(*) as new_subscriber from subscription_dim where trunc(START_DATE) = TRUNC(SYSDATE -1)
/
EXIT

EOF

#echo "File Exported for $dt"

rm -f $lock

fi


